#!/bin/bash

# pick largest report
find ~/log/nmapA -mindepth 1 -type d | 
grep / > /tmp/dir

while IFS= read -r line
do
    cd $line
    pwd
    du -b -a | sort -n -r | head -n 2 | grep log | awk '{print $2}' | xargs cat > largest_log 
    cd -

done < /tmp/dir

# generate html file
find ~/log/nmapA/ -mindepth 2 -name "largest_log" | sort -V > /tmp/largest_logs
cat /tmp/largest_logs | xargs cat | sed -e "s/Starting/\n\n----------\nStarting/g" > ~/log/nmapA_list.txt
echo "<xmp>" > ~/log/nmapA_list.html
cat ~/log/nmapA_list.txt >> ~/log/nmapA_list.html
echo "</xmp>" >> ~/log/nmapA_list.html

# link to http server
# sudo ln -s /tmp/nmapA_list.html /var/www/html
