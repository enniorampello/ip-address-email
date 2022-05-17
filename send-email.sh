#!/bin/bash
# check and send ip address to email
 
MYIP=`curl ifconfig.me`;
TIME=`date`;
 
LASTIPFILE='/home/ennio/.last_ip_addr';
LASTIP=`cat ${LASTIPFILE}`;
 
if [[ ${MYIP} != ${LASTIP} ]]
then
        echo "New IP = ${MYIP}"
        echo "sending email.."
        echo -e "Hello\n\nTimestamp = ${TIME}\nIP = ${MYIP}\n\nBye" | \
                /usr/bin/mail -s "[INFO] New IP" <YOUR_EMAIL>;
        echo ${MYIP} > ${LASTIPFILE};
else
        echo "no IP change!"
fi
