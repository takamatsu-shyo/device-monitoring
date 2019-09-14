#!/bin/bash

# nmap -A to all hosts
while IFS= read -r line
do
    dir=$(echo "$line" | sed 's/\./-/g' |  sed 's/^/\/tmp\/log\/nmapA\//g')
    date_str=$(date -Iminute)
    logfile=""$date_str"_log"
    echo "$dir"
    echo "$dir" | xargs mkdir -p
    cd "$dir"
    echo "$line" | sudo xargs nmap -A > $logfile 
    cd -
done < /tmp/uniq_ip

