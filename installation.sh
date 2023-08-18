#!/bin/bash

clear
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
                echo -e "$R $i Installation failuree $W"
        fi
}

DATE=$(date +%F)
LOG_FILE=/tmp/$DATE.log
packages=("$@")


for i in "${packages[@]}"
do
        which $i &> /dev/null
        if [[ $? -ne 0 ]]
        then
           yum install $i -y &>> $LOG_FILE
           VALIDATE $i
        else
           echo "$i already installed"
        fi
done