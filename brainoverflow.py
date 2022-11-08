#!/usr/bin/env python
import sys
from brainflow.board_shim import BoardIds, BoardShim, BrainFlowInputParams, LogLevels
from brainflow.data_filter import DataFilter
import numpy as np
import pandas as pd
sample = sys.argv[1]


def try_one():
    print(sample)
    try:
        restored_data = DataFilter.read_file(sample)
        restored_df = pd.DataFrame(np.transpose(restored_data))
        print(restored_df.head(10))
    except ValueError:
        print("")


def main():
    #    try_all()
    try_one()


if __name__ == "__main__":
    main()
