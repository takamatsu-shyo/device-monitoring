#!/bin/bash

# nmap -A to all hosts
while IFS= read -r line
do
    dir=$HOME"/log/nmapA/"$line
    date_str=$(date -Iminute)
    logfile=""$date_str"_log"
    echo "$dir"
    echo "$dir" | xargs mkdir -p
    cd "$dir"
    echo "$line" | sudo xargs nmap -A > $logfile 
    cd -
done < ~/log/uniq_ip

~/device-monitoring/gen_contents.sh
