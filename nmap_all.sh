#!/bin/bash
# nmap -A to all hosts in LAN
start=`date +%s`


date_str=$(date -Iminute)
logfile=""$date_str"_log"
 
while IFS= read -r line
do
    (dir=$HOME"/log/nmapA/"$line
    echo "$dir"
    echo "$dir" | xargs mkdir -p
    cd "$dir"
    echo "$line" | sudo xargs nmap -A > $logfile 
    echo "$dir "complete
    cd -)&
done < ~/log/uniq_ip

wait

end=`date +%s`
duration=$(expr $((end)) - $((start)))
echo "Took "$duration" sec"

