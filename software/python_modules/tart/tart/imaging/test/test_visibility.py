import unittest
import datetime
import h5py
import numpy as np

from tart.util import skyloc
from tart.util import angle

import tart.operation.settings as settings
import tart.imaging.visibility as visibility

VIS_DATA_FILE='tart/test/test_data/fpga_2019-02-22_05_11_41.765212.vis'
ANT_POS_FILE='tart/test/test_calibrated_antenna_positions.json'

def dummy_vis():
    config = settings.from_file('tart/test/test_telescope_config.json')
    ret = visibility.Visibility(config=config, timestamp=datetime.datetime.utcnow())
    b = []
    v = []
    for j in range(24):
        for i in range(24):
            if i > j:
                b.append([j,i])
                v.append(np.random.uniform(0,1) + np.random.uniform(0,1)*(1.0j))
    ret.set_visibilities(b=b, v=v)
    return ret 

class TestVisibility(unittest.TestCase):

    def setUp(self):
        self.v_array = visibility.Visibility_Load(VIS_DATA_FILE)
        self.v_array[0].config.load_antenna_positions(cal_ant_positions_file=ANT_POS_FILE)
        
    def test_load_save(self):
        dut = dummy_vis()
        visibility.Visibility_Save_JSON(self.v_array[0], 'test_vis_save.json')
        
        pass
    
    def test_hdf5(self):
        dut = dummy_vis()
        visibility.to_hdf5(dut, 'test_vis_save.hdf')
        dut2 = visibility.from_hdf5('test_vis_save.hdf')
        
        self.assertTrue((dut.v == dut2.v).all())
        self.assertTrue((dut.baselines == dut2.baselines).all())
        self.assertEqual(dut.config.Dict, dut2.config.Dict)
    
    def test_zero_rotation(self):
        v = self.v_array[0]
        v_before = np.array(v.v) # Copy the visibilities
        el1 = v.phase_el
        az1 = v.phase_az

        ra, decl = v.config.get_loc().horizontal_to_equatorial(v.timestamp, el1, az1)
        
        v.rotate(skyloc.Skyloc(ra, decl))
        
        v_after = np.array(v.v)
        self.assertEqual(v.phase_el.to_degrees(), el1.to_degrees())

        for x,y in zip(v_before, v_after):
            self.assertAlmostEqual(np.abs(x), np.abs(y), 4)

    def test_full_rotation(self):
        v = self.v_array[0]
        v_before = np.array(v.v) # Copy the visibilities
        el1 = v.phase_el
        az1 = v.phase_az
        ra, decl = v.config.get_loc().horizontal_to_equatorial(v.timestamp, el1, az1)

        # Pick a baseline


        # Calculate the angle to offset the RA, DEC to produce a full rotation
        #

        v.rotate(skyloc.Skyloc(ra + angle.from_dms(0.05), decl))
        v_after = np.array(v.v)
        self.assertAlmostEqual(v.phase_el.to_degrees(), el1.to_degrees(), 0)
        for x,y in zip(v_before, v_after):
            self.assertAlmostEqual(np.angle(x),np.angle(y),1)
            self.assertAlmostEqual(np.abs(x),np.abs(y),2)
