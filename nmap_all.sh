#!/bin/bash


while IFS= read -r line
do
    dir=$(echo "$line" | sed 's/\./-/g' |  sed 's/^/\/tmp\/log\/nmapA\//g')
    echo "$dir"
    echo "$dir" | xargs mkdir -p
    cd "$dir"
    echo "$line" | xargs nmap -A > log 
    cd -
done < /tmp/uniq_ip
