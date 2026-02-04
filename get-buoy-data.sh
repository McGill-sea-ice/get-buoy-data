#!/bin/bash
# to be run each day, checking for new emails from sbd.iridium.com
# and downloading and categorizing the attachments
echo "---------- get-buoy-data.sh -----------"
echo " "
date

# load conda environment
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate /opt/anaconda3/envs/buoy-data

python3 /storage/common/buoy-data/get-buoy-data/get-buoy-data.py
