#!/bin/bash

# set cron job to this script

#TODO: web interface 
#TODO: log rotate
#TODO: mail integration

sudo nmap -sn 192.168.1.1-255 > /tmp/nmap_list

#-----------------------------------------
# nmap -A for all device with external script
# nmap_all.sh
cat /tmp/all_list | 
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | 
sort | 
uniq > /tmp/uniq_ip

