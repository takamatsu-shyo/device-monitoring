#!/bin/bash

# pick largest report
find /tmp/log/nmapA -type d | 
grep / > /tmp/dir

#cat /tmp/dir | xargs | du -b -a | sort -n -r | head -n 2 | grep log | awk '{print $2}' 
while IFS= read -r line
do
    cd $line
    du -b -a | sort -n -r | head -n 2 | grep log | awk '{print $2}' | xargs cat > largest_log 
    cd -

done < /tmp/dir

# generate html file
find /tmp/log/nmapA/ -mindepth 2 -name "largest_log" | xargs cat | sed -e "s/Starting/\n\n----------\nStarting/g" > /tmp/nmapA_list.txt
echo "<xmp>" > /tmp/nmapA_list.html
cat /tmp/nmapA_list.txt >> /tmp/nmapA_list.html
echo "</xmp>" >> /tmp/nmapA_list.html

# link to http server
# sudo ln -s /tmp/nmapA_list.html /var/www/html
