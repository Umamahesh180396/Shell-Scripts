#!/bin/bash

R="\e[31m"
G="\e[32m"
W="\033[0m"


if [[ $(id -u) -ne 0 ]]
then
        echo -e "$R ERROR : Please run this sctipt with root user. Please swich to root and try $W"
        exit 1
fi

if [[ $# -eq 0 ]]
then
        echo -e "$R ERROR: Please input package names $W"
        exit 2
fi

VALIDATE()
{
        if [[ $? -eq 0 ]]
        then
                echo -e "$G $i Installation success $W"
        else
                echo -e "$R $i Installation failure $W"
        fi
}

DATE=$(date +%F)
LOG_FILE=/tmp/$DATE.log
packages=("$@")

for i in "${packages[@]}"
do
        yum list validate | grep $i &>> /dev/null
        if [[ $? -eq 0 ]]
        then
                which $i &> /dev/null
                if [[ $? -ne 0 ]]
                then
                        yum install $i -y &>> $LOG_FILE
                        VALIDATE $i
                else
                echo "$i already installed"
                fi
        else
                echo -e "$R Given package $i not available. Please check $W"
        fi
done
