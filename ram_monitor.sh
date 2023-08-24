#!/usr/bin/env bash

DATE=$(date +%F)
SCRIPT_NAME="$0"
LOG_FILE=/tmp/$SCRIPT_NAME-$DATE.log
THRESHOLD_VALUE=400
TO_ADDRESS="maheshthota2136@gmail.com"

AVAILABLE_MEMORY=$(free -m | grep Mem | awk '{print $4}')

if [[ $AVAILABLE_MEMORY -le $THRESHOLD_VALUE ]]
then
    echo "Available memory: $AVAILABLE_MEMORY" &>> "$LOG_FILE"
    echo "Memory limit exceeded...Sending alert" &>> "$LOG_FILE"
    echo "There is high memory usage identified on $(hostname) and available memory: $AVAILABLE_MEMORY on $DATE" | mail -s "RAM_MONITORING" $TO_ADDRESS &>> "$LOG_FILE"
else
    echo "Available memory: $AVAILABLE_MEMORY" &>> "$LOG_FILE"
    echo "Usage is under threshold value" &>> "$LOG_FILE"
fi