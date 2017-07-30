
import database as db


import datetime
import dateutil.parser
import os, stat, time
import traceback

import json
import requests

import numpy as np
from numpy import concatenate as cc
from scipy.optimize import minimize

from tart.operation import settings
from tart.imaging import visibility
from tart.imaging import calibration
from tart.imaging import antenna_model
from tart.imaging import radio_source
from tart.imaging import correlator
from tart.imaging import location
from tart.simulation import skymodel
from tart.simulation import antennas
from tart.simulation import radio
from tart.simulation.simulator import get_vis_parallel, get_vis

msd_vis = []
sim_vis = []
N_IT = 0

def optimize_phaseNgain(opt_parameters):
  global msd_vis, sim_vis, N_IT
  gains, phase_offsets = opt_parameters[:23], opt_parameters[23:]
  """Set phase offsets in list of calibrated visibility objects. Calculate and return likelihood"""
  for key in msd_vis.keys():
    ant_idxs = range(1, 24)
    for i, g in enumerate(gains):
      if g<0:
        gains[i] = -g
        phase_offsets[i] += np.pi
    msd_vis[key].set_phase_offset(ant_idxs, phase_offsets)
    msd_vis[key].set_gain(ant_idxs, gains)
  ret = likelihood_vis_dicts(msd_vis, sim_vis, debug=False)
  N_IT += 1
  if (N_IT%20==0):
    db.update_calibration_process_state(str(ret))
    print ret#, phase_offsets, gains
  return ret

def vis_diff(vis1, vis2, ant_a, ant_b):
  """ Calculate difference of complex visibilities vis1 and vis2 for baseline ant_a and ant_b"""
  ret = np.power(np.abs(vis1.get_visibility(ant_a, ant_b)-vis2.get_visibility(ant_a, ant_b)), 2)
  return ret

def likelihood_vis_dicts(msd_vis, sim_vis, debug=False):
  """Calculate likelihood from lists of measured and simulated visibilities"""
  ret = 0.
  for key in msd_vis.keys():
    meas_v = msd_vis[key]
    sim_v = sim_vis[key]
    bls_meas = meas_v.get_baselines() # flagging based on measured visibilities
    if debug:
      print 'Number of baselines contributing: ', len(bls_meas)
    for bln in bls_meas:
      [ant_i, ant_j] = bln
      ret += vis_diff(meas_v, sim_v, ant_i, ant_j)*np.abs(sim_v.get_visibility(ant_i, ant_j))
  return ret

def vis_object_from_response(vis, ts, SETTINGS):
  bl = [eval(k) for k in vis.keys()]
  ret = visibility.Visibility(SETTINGS, ts)
  v_order = []
  for b in bl:
    v_real, v_imag = vis[str(b)]
    v_order.append(v_real + 1j*v_imag)
  ret.set_visibilities(v_order, bl)
  return ret

def calibrate_from_vis(cal_measurements, runtime_config):
    MODE = 'mini'
    #simp (use only when noise present)\
    #mini, perfect visibilities.\
    #full

    SETTINGS = settings.from_file(runtime_config['telescope_config_path'])
    ANTS = [antennas.Antenna(location.get_loc(SETTINGS), pos) for pos in runtime_config['antenna_positions']]
    ANT_MODELS = [antenna_model.GpsPatchAntenna() for i in range(SETTINGS.get_num_antenna())]
    NOISE_LVLS = 0.0 * np.ones(SETTINGS.get_num_antenna())
    RAD = radio.Max2769B(n_samples=2**12, noise_level=NOISE_LVLS)
    COR = correlator.Correlator()

    global msd_vis, sim_vis
    sim_vis = {}
    msd_vis = {}
    sim_sky = {}

    for m in cal_measurements:
      timestamp = dateutil.parser.parse(m['data']['timestamp'])

      key = '%f,%f,%s' % (m['el'], m['az'], timestamp)
      # Generate model visibilities according to specified point source positions
      sim_sky[key] = skymodel.Skymodel(0, location=location.get_loc(SETTINGS), gps=0, thesun=0, known_cosmic=0)
      sim_sky[key].add_src(radio_source.ArtificialSource(location.get_loc(SETTINGS), timestamp, m['el'], m['az']))
      v_sim = get_vis(sim_sky[key], COR, RAD, ANTS, ANT_MODELS, SETTINGS, timestamp, mode=MODE)
      sim_vis[key] = calibration.CalibratedVisibility(v_sim)

      # Construct (un)calibrated visibility objects from received measured visibilities
      vis = vis_object_from_response(m['data']['vis'], timestamp, SETTINGS)
      msd_vis[key] = calibration.CalibratedVisibility(vis)

    # Define initial optimisation paramters

    opt_param = np.ones(46)
    opt_param[:23] = np.ones(23)
    opt_param[23:] = np.zeros(23)

    # Run optimisation
    RES = minimize(optimize_phaseNgain, opt_param)

    utc_date = datetime.datetime.utcnow()
    phases = msd_vis.values()[0].get_phase_offset(np.arange(24))
    gains = msd_vis.values()[0].get_gain(np.arange(24))
    #content =  msd_vis.values()[0].to_json(filename='/dev/null')
    db.insert_gain(utc_date, gains, phases)
    db.update_calibration_process_state('idle')
    return {}

def cleanup_observation_cache():
    while True:
        resp = db.get_raw_file_handle()
        if len(resp)>10:
            for entry in resp[10:]:
                try:
                    os.remove(entry['filename'])
                except:
                    print 'couldnt remove file'
                    pass
                try:
                    db.remove_raw_file_handle_by_Id(entry['Id'])
                    print 'removed', entry['Id'], entry['filename'], entry['checksum']
                except:
                    print 'couldnt remove handle from database'
                    pass
        else:
            db.update_observation_cache_process_state('OK')
        time.sleep(60)

from tart_dsp.tartspi import TartSPI
from tart_dsp.highlevel_modes_api import *
from tart_dsp.stream_vis import *

class TartControl():
    ''' High Level TART Interface'''
    def __init__(self, runtime_config):
        self.TartSPI = TartSPI()
        self.config = runtime_config
        self.state = 'off'
        self.queue_vis = None
        self.process_vis_calc = None
        self.cmd_queue_vis_calc = None
        self.process_capture = None
        self.cmd_queue_capture = None

    def run(self):
        if self.state == 'diag':
            run_diagnostic(self.TartSPI, self.config)
            db.insert_sample_delay(self.config['channels_timestamp'], self.config['sample_delay'])

        elif self.state == 'raw':
            ret = run_acquire_raw(self.TartSPI, self.config)
            if ret.has_key('filename'):
                db.insert_raw_file_handle(ret['filename'], ret['sha256'])

        elif self.state == 'vis':
            if (self.queue_vis is None):
                self.vis_stream_setup()
            else:
                self.vis_stream_acquire()
                time.sleep(0.005)

        elif self.state == 'off':
            time.sleep(0.5)
        else:
            print 'unknown state'

    def set_state(self, new_state):
        if (new_state == self.state):
            return
        else:
            ''' State Transition '''
            if (self.state == 'vis'):
                '''Cleanup vis acquisition queues and processes'''
                self.vis_stream_finish()
            self.state = new_state

    def vis_stream_setup(self):
        self.queue_vis,\
        self.process_vis_calc,\
        self.process_capture,\
        self.cmd_queue_vis_calc,\
        self.cmd_queue_capture,\
        = stream_vis_to_queue(self.TartSPI, self.config)

    def vis_stream_acquire(self):
        ''' Get all available visibities'''
        vislist = []
        while self.queue_vis.qsize()>0:
            vis, means = self.queue_vis.get()
            vislist.append(vis)

            if len(vislist)==self.config['vis']['chunksize']:
                if self.config['vis']['save']:
                    fname = self.config['vis']['vis_prefix'] + "_" + vis.timestamp.strftime('%Y-%m-%d_%H_%M_%S.%f')+".vis"
                    visibility.Visibility_Save(vislist, fname)
                    print 'saved ', vis, ' to', fname
                vislist = []
            if vis is not None:
                d = {}
                for (b, v) in zip(vis.baselines, vis.v):
                    key = str(b)
                    d[key] = (v.real, v.imag)
                print 'updating latest visibilities in runtime dict.'
                self.config['vis_current'] = d
                self.config['vis_timestamp'] = vis.timestamp

    def vis_stream_finish(self):
        self.cmd_queue_capture.put('stop')
        self.cmd_queue_vis_calc.put('stop')
        self.process_capture.join()
        self.process_vis_calc.join()
        self.queue_vis = None
        print 'Stop visibility acquisition processes.'

    def vis_stream_reconfigure(self):
        self.vis_stream_finish()
