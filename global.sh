#!/bin/bash

#global val
account=""
p1=""
p2=""
sno=""
sname=""
sex=""
English=""
Linux=""
Java=""
Mysql=""
sum=""
avg=""

account=/root/stu_sys/account.txt
s_account=/root/stu_sys/s_account.txt
stu_message=/root/stu_sys/stu_message.txt

if [ ! -f "$account" ]
then
        touch "$account"
        echo -ne "id\tpassword\n" >> $account
fi
if [ ! -f "$s_account" ]
then
        touch "$s_account"
        echo -ne "sid\tspassword\n" >> $s_account
fi
if [ ! -f "$stu_message" ]
then
	touch "$stu_message"
	echo -ne "sno\tsname\t\tsex   English\tLinux\tJava\tMysql\tsum\tavg\n" >> $stu_message
fi
