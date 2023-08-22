#!/usr/bin/env bash

cr=$(echo $'\n.')
cr=${cr%.}

read -s -p "Please enter password: $cr" PASSWORD
read -p "Please enter gmail account name: $cr" EMAIL

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
    if [[ $? -ne 0 ]]
        then
                echo -e "$1 $R Failure $W"
                exit 2
        else
                echo -e "$1 $G Success $W"
        fi
}

#Update yum repo

yum update -y --exclude=kernel* &>> $LOG_FILE

VALIDATE "Update yum repo...."

#Install Postfix, the SASL authentication framework, and mailx.

yum -y install postfix cyrus-sasl-plain mailx &>> $LOG_FILE

VALIDATE "Install Postfix, the SASL authentication framework, and mailx...."

#Restart Postfix to detect the SASL framework

systemctl restart postfix &>> $LOG_FILE

VALIDATE "Restart of postfix...."

#Start Postfix on boot

systemctl enable postfix &>> $LOG_FILE

VALIDATE "Enable postfix...."

#Appending content to /etc/postfix/main.cf

echo "
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
" >> /etc/postfix/main.cf 

VALIDATE "Appending content...."

# Create a sasl_passwd under /etc/postfix

touch /etc/postfix/sasl_passwd

VALIDATE "sasl_passwd file creation...."

#Add gmail id and password from google management app password

echo "[smtp.gmail.com]:587 maheshthota2136:$PASSWORD" > /etc/postfix/sasl_passwd

VALIDATE "Adding gmail ID and password...."

#Create a Postfix lookup table from the sasl_passwd text file by running the following command

postmap /etc/postfix/sasl_passwd

VALIDATE "PASSWORD mapping...."

#Sending mail Run the following command to send mail:

echo "This is a test mail for gmail installation & Date $DATE" | mail -s "test message" $EMAIL

echo -e "$G Email has been sent $W"













 



