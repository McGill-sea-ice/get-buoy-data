# get-buoy-data
Python code to download attached Iridium sbd files from emails in a gmail account.

# Documentation and usage

## Preparations

### Gmail access via API
To access a gmail account using python, we need to enable the [gmail API](https://developers.google.com/workspace/gmail/api/reference/rest) for the gmail account that we want to access and get credentials. Please refer to this website and follow the steps: https://thepythoncode.com/article/use-gmail-api-in-python  
Once finished with those steps you should have a file `credentials.json` in your local `get-buoy-data` directory. When running the code for the first time, you will have to verify your identity using a web browser and whichever two-factor-authentification method you are using. After the successful verification, there should also be a file `token.pickle` in the `get-buoy-data` directory, which will be used for future log-ins. Note that the token in `token.pickle` will only be valid for one week if your gmail Desktop App stays in "testing" mode. To enable unlimited access with the token, you need to "publish" your Desktop App.

### conda environment
The python code in `get-buoy-data.py` requires certain modules included in `environment.yml`. We thus create a [conda](https://anaconda.org/channels/anaconda/packages/conda/overview) environment with those modules that we can later load to run the code. `conda env create -f environment.yml` will create the required environment.


## Usage
After loading the conda environment, run `python get-buoy-data.py`. This will scan the gmail inbox of the account associated to the credentials for emails from `sbd.iridium.com` with attachments and download those. The attachments will be saved in subfolders of `get-buoy-data/` which will have the IMEI of the instrument that the email came from as a folder name. After `get-buoy-data.py` is run for the first time, it will create a file `last_access` that saves the last time the gmail account was accessed by the script. The next time `get-buoy-data.py` is run, it will only download attachemnts from emails newer than the timestamp saved in `last_access`.

### Automation
The file `get-buoy-data.sh` contains bash code that handles loading the correct conda environment and executing `get-buoy-data.py`. Note that `source /opt/anaconda3/etc/profile.d/conda.sh` is necessary due to the way the conda environments are set up on the machine that this code was developped on but almost certainly needs to be adjusted or removed depending on your local machine.  
An example of how use [cron](https://en.wikipedia.org/wiki/Cron) to automatically run `get-buoy-data.sh` every day to check for new emails with attachments is shown in `to_crontab`. Including this in your crontab will create a log file `get-buoy-data.log`. Don't forget to adjust paths and directories.
