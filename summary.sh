#!/bin/bash

cp $HOME/log/summary.txt $HOME/log/summary_last

#sudo nmap 192.168.1.1-255 -sn > /tmp/summary.txt
cp  $HOME/log/nmap_list /tmp/summary

cat /tmp/summary |
grep -v 'Nmap done' | 
grep -v 'Starting' | 
grep -v 'Host is up' | 
paste - - -d' ' | 
sed  's/Nmap scan report for //g' | 
sed 's/MAC address: //g'  > /tmp/summary_.txt

cat /tmp/summary_.txt | 
awk 'match($1,/[0-9].*[0-9]/){print $0}' |
sed 's/MAC Address: //g' > /tmp/summary_nohostname

cat /tmp/summary_.txt | 
awk 'match($2,/([0-9].*[0-9])/){print $2" "$1" "$5" "$6" "$7" "$8" "$9}' | 
sed 's/^(//g' | 
sed 's/) / /g' |
sed 's/\s*$/)/' > /tmp/summary_hostname 

cat /tmp/summary_hostname /tmp/summary_nohostname |
sort -t . -k 3,3n -k 4,4n > $HOME/log/summary_now

cat $HOME/log/summary_now $HOME/log/summary_last |
sort -t . -k 3,3n -k 4,4n |
uniq > $HOME/log/summary.txt
