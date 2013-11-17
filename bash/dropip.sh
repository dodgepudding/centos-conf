#!/bin/bash
IPTABLES=/sbin/iptables
netstat -an | grep :80 | awk -F: '{ print $8 }' | sort | uniq -c | awk -F\   '$1>10 && $2!="" { print $2 }' >> /etc/fw.list
less /etc/fw.list | sort | uniq -c | awk -F\   '$2!="" { print $2 }' > /etc/fw.list2
less /etc/fw.list2 > /etc/fw.list
while read line
       do
       t=`echo "$line"`
       $IPTABLES -A INPUT -p tcp -s $t -j DROP
done < /etc/fw.list2

