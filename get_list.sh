#!/bin/bash

# set cron job to this script

#TODO: web interface 
#TODO: log rotate
#TODO: mail integration

sudo nmap -sn 192.168.1.1-255 > /tmp/nmap_list

#---------------------------------------
# Trial 1 to detect device UP/DOWN
mv /tmp/this_list /tmp/last_list 
cat /tmp/nmap_list | grep 'report for' | awk -F' ' '{print $5 $6 }' > /tmp/this_list
diff /tmp/last_list /tmp/this_list |  grep '>' | sed -e "s/>/$(date -Isecond)/g" | sed -e 's/$/ UP/g'   >> ~/log/device_log
diff /tmp/last_list /tmp/this_list |  grep '<' | sed -e "s/</$(date -Isecond)/g" | sed -e 's/$/ DOWN/g' >> ~/log/device_log

#----------------------------------------
# Trial 2 to detect device UP/DOWN
# UP for 5min then UP
# DOWN for 5min then DOWN

# Device list now
cat /tmp/nmap_list | sed -e 's/Host is up.*\.//g' | grep -v Starting | grep -v done | xargs -n3 -d'\n' | sed 's/Nmap scan report for //g' | sed 's/ MAC Address: //g' > /tmp/all_list_wot
cat /tmp/all_list_wot | sort | sed -e 's/\s$//g'> /tmp/device_list_now

# Add device list now to all_list
cat /tmp/device_list_now | sed -e "s/^/$(date -Isecond) /g" >> /tmp/all_list

# For UP
#  Get device list last 5 min
for (( i = 5; i >=0; i-- )) ; do
	echo $(date -Imin -d "$i min ago") | sed -e 's/+.*//g' > /tmp/time_str
	cat /tmp/all_list | grep "$(cat /tmp/time_str)" | egrep -o '\s.*)'| sed -e 's/^ //g' | sort | uniq >> /tmp/device_list_last5min
done
cat /tmp/device_list_last5min | sort | uniq > /tmp/device_list_log
#diff /tmp/device_list_log /tmp/device_list_now |  grep '<' | sed -e "s/</$(date -Isecond)/g" | sed -e 's/$/ DOWN/g' >> ~/log/updown_log
diff /tmp/device_list_log /tmp/device_list_now |  grep '>' | sed -e "s/>/$(date -Isecond)/g" | sed -e 's/$/ UP/g'   >> ~/log/updown_log

# For DOWN
cat /tmp/all_list | grep "$(date -Imin -d "5 min ago")" | egrep -o '\s.*)'| sed -e 's/^ //g' | sort | uniq > /tmp/device_list_5minago

for (( i = 4; i >=1; i-- )) ; do
	echo $(date -Imin -d "$i min ago") | sed -e 's/+.*//g' > /tmp/time_str
	cat /tmp/all_list | grep "$(cat /tmp/time_str)" | egrep -o '\s.*)'| sed -e 's/^ //g' | sort | uniq >> /tmp/device_list_4-1
done

cat /tmp/device_list_4-1 /tmp/device_list_now > /tmp/device_list_4-0
diff /tmp/device_list_5minago /tmp/device_list_4-0 |  grep '<' | sed -e "s/</$(date -Isecond)/g" | sed -e 's/$/ DOWN/g' >> ~/log/updown_log

#-----------------------------------------
# nmap -A for all device with external script
# nmap_all.sh
cat /tmp/all_list | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort | uniq > /tmp/uniq_ip

