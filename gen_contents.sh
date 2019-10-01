#!/bin/bash
# This script generate one page report about nmap -A to all hosts

# pick largest report
find ~/log/nmapA -mindepth 1 -type d | 
grep / > /tmp/dir

while IFS= read -r line
do
    cd $line
    pwd
    mv largest_log largest_log_bu
    du -b -a | sort -n -r | head -n 2 | grep log | awk '{print $2}' | xargs cat > largest_log 
    cat largest_log | wc -l
    cd -

done < /tmp/dir

# generate html file
TXT_FILE=~/log/nmapA_list.txt
HTML_FILE=~/log/nmapA_list.html

find ~/log/nmapA/ -mindepth 2 -name "largest_log" | sort -V > /tmp/largest_logs

REPORT_DATE=$(echo 'Report generated: ')
REPORT_DATE+=$(date -Iminute)
echo $REPORT_DATE >$TXT_FILE 
cat /tmp/largest_logs | xargs cat | sed -e "s/Starting/\n\n----------\nStarting/g" >>$TXT_FILE 

echo "<xmp>" >$HTML_FILE 
cat ~/log/nmapA_list.txt >>$HTML_FILE
echo "</xmp>" >>$HTML_FILE

# link to http server
# sudo ln -s /tmp/nmapA_list.html /var/www/html
