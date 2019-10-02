#!/bin/bash

sudo nmap 192.168.1.1-255 -sn > /tmp/summary.txt

cat /tmp/summary.txt  | 
grep -v 'Nmap done' | 
grep -v 'Starting' | 
grep -v 'Host is up' | 
paste - - -d' ' | 
sed  's/Nmap scan report for //g' | 
sed 's/MAC address: //g'  > /tmp/summary_.txt

cat /tmp/summary_.txt | 
awk 'match($1,/[0-9].*[0-9]/){print $0}' > /tmp/summary_nohostname

cat /tmp/summary_.txt | 
awk 'match($2,/([0-9].*[0-9])/){print $2" " $1" "$5" "$6}' | 
sed 's/^(//g' | 
sed 's/) / /g' > /tmp/summary_hostname 

cat /tmp/summary_hostname /tmp/summary_nohostname > ~/log/summary.txt

#TODO: hostname, if MAC manufacturer contain space then lose after first space
#TODO: nohostname, MAC Address is remained
#TODO: -sn result can be obtained from get_nmaplist.sh result
#      think about how to get largest log since sometimes failed to -sn
