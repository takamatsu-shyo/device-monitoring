#!/bin/bash
mv this_list last_list 
nmap -sn 192.168.1.1-255  | grep 'report for' | awk -F' ' '{print $5 $6 }' > this_list
diff last_list this_list |  grep '>' | sed -e "s/>/UP    $(date -Isecond)/g" >> device_log
diff last_list this_list |  grep '<' | sed -e "s/</DOWN  $(date -Isecond)/g" >> device_log
