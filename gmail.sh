#!/usr/bin/env bash

read -p "Please enter password: " PASSWORD
read -p "Please enter gmail account name: " EMAIL

DATE=$(date +%F)
LOG_PATH=/tmp
SCRIPT_NAME="$0"
LOG_FILE=/tmp/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
W="\033[0m"
Y="\e[33m"

if [[ $(id -u) -ne 0 ]]
then
        echo -e "$R ERROR : Please run this sctipt with root user. Please swich to root and try $W"
        exit 1
fi

VALIDATE()
{
    if [[ $? -eq 0 ]]
        then
                echo -e "$G Success $W"
        else
                echo -e "$R Failure $W"
        fi
}

yum update -y --exclude=kernel* &>> $LOG_FILE

VALIDATE

yum -y install postfix cyrus-sasl-plain mailx &>> $LOG_FILE

VALIDATE

systemctl restart postfix &>> $LOG_FILE

VALIDATE

systemctl enable postfix &>> $LOG_FILE

VALIDATE

echo "
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
" >> /etc/postfix/main.cf 

touch /etc/postfix/sasl_passwd

echo "[smtp.gmail.com]:587 maheshthota2136:$PASSWORD" > /etc/postfix/sasl_passwd

postmap /etc/postfix/sasl_passwd

echo "This is a test mail & Date $DATE" | mail -s "test message" $EMAIL

echo -e "$G Email has been sent $W"













 



