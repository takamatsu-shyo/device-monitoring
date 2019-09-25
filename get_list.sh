#!/bin/bash

# set cron job to this script

sudo nmap -sn 192.168.1.1-255 > ~/log/nmap_list

cat ~/log/nmap_list | 
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | 
sort | 
uniq > ~/log/uniq_ip_now

cp ~/log/uniq_ip ~/log/uniq_ip_before
cat ~/log/uniq_ip_now ~/log/uniq_ip_before |
sort | 
uniq > ~/log/uniq_ip
