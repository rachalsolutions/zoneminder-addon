#!/usr/bin/env bash
set -e

# Path the the json options
CONFIG_PATH=/data/options.json

# Extract the variables for the the json file
ZM_DB_USER=$(jq --raw-output '.zoneminder_db_username // empty' $CONFIG_PATH)
ZM_DB_PASS=$(jq --raw-output '.zoneminder_db_password // empty' $CONFIG_PATH)
ZM_DB_NAME=$(jq --raw-output '.zoneminder_db_name // empty' $CONFIG_PATH)
ZM_DB_HOST=$(jq --raw-output '.zoneminder_db_hostname // empty' $CONFIG_PATH)

# Export to environment variables
export ZM_DB_USER="${ZM_DB_USER}"
export ZM_DB_PASS="${ZM_DB_PASS}"
export ZM_DB_NAME="${ZM_DB_NAME}"
export ZM_DB_HOST="${ZM_DB_HOST}"

# Echo to the console so you know it worked
echo "Zone Minder DB username: ${ZM_DB_USER}"
echo "Zone Minder DB name: ${ZM_DB_NAME}"
echo "Zone Minder DB hostname: ${ZM_DB_HOST}"

# Do a test ping
ping $ZM_DB_HOST -c 5

# Run the main script
/usr/local/bin/entrypoint.sh
