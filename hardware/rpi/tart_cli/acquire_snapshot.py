# SETUP

# Create local data directory and change owner to pi:
#    sudo mkdir /data
#    sudo chown pi:pi /data


from tart_hardware_interface.tartspi import TartSPI
from tart_hardware_interface.highlevel_modes_api import *

import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Test bench for TART commuication via SPI."
    )
    parser.add_argument(
        "--speed", default=32, type=int, help="Specify the SPI CLK speed (in MHz)"
    )
    parser.add_argument(
        "--bramexp", default=21, type=float, help="exponent of bram depth"
    )
    parser.add_argument(
        "--debug", action="store_true", help="operate telescope with fake antenna data."
    )
    parser.add_argument(
        "--data-dir", required=True, help="The filesystem path for the telescope data."
    )
    parser.add_argument(
        "--config-file",
        default="telescope_config.json",
        help="The telescope configuration file.",
    )
    parser.add_argument(
        "--reset", action="store_true", help="reset after transmission?"
    )
    parser.add_argument("--internal", action="store_true", help="fake data generator")
    parser.add_argument(
        "--counter", action="store_true", help="fake data using a counter"
    )
    parser.add_argument("--shifter", action="store_true", help="fake data using a MFSR")
    parser.add_argument("--verbose", action="store_true", help="extra debug output")
    parser.add_argument("--save", action="store_true", help="save acquisition")

    args = parser.parse_args()

    # Initialise the TART hardware, and place it into a known state.

    runtime_config = {}
    runtime_config["spi_speed"] = args.speed * 1000000
    runtime_config["acquire"] = not args.internal
    runtime_config["shifter"] = args.shifter
    runtime_config["counter"] = args.counter
    runtime_config["verbose"] = args.verbose
    runtime_config["centre"] = True
    runtime_config["blocksize"] = 22
    runtime_config["raw"] = {
        "save": args.save,
        "N_samples_exp": args.bramexp,
        "config": args.config_file,
        "base_path": args.data_dir,
    }
    runtime_config["diagnostic"] = {
        "num_ant": 24,
        "N_samples": 100,
        "stable_threshold": 0.95,
    }

    tart = TartSPI(speed=runtime_config["spi_speed"])
    run_acquire_raw(tart, runtime_config)
