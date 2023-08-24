#!/usr/bin/env bash

DATE=$(date +%F)
LOG_PATH=/tmp
SCRIPT_NAME="$0"
LOG_FILE=/tmp/$SCRIPT_NAME-$DATE.log
THRESHOLD_VALUE=100
TO_ADDRESS="maheshthota2136@gmail.com"

R="\e[31m"
G="\e[32m"
W="\033[0m"
Y="\e[33m"

AVAILABLE_MEMORY=$(free -m | grep Mem | awk '{print $4}')

if [[ $AVAILABLE_MEMORY -le $THRESHOLD_VALUE ]]
then
    echo -e "$R Available memory: $AVAILABLE_MEMORY $W" &>>LOG_FILE
    echo -e "$R Memory limit exceeded...Sending alert $W" &>> LOG_FILE
    echo "There is high memory usage identified on $(hostname) and available memory: $AVAILABLE_MEMORY on $DATE" | mail -s "RAM_MONITORING" $TO_ADDRESS &>> LOG_FILE
else
    echo "$G Available memory: $AVAILABLE_MEMORY $W" &>>LOG_FILE
    echo "$G Usage is under threshold value $W" &>>LOG_FILE
fi