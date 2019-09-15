#!/bin/bash

# set cron job to this script

sudo nmap -sn 192.168.1.1-255 > /tmp/nmap_list

cat /tmp/nmap_list | 
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | 
sort | 
uniq > /tmp/uniq_ip_now

cp /tmp/uniq_ip /tmp/uniq_ip_before
cat /tmp/uniq_ip_now /tmp/uniq_ip_before |
sort | 
uniq > /tmp/uniq_ip
