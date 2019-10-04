#!/bin/bash
# This script change color scheme to tropical sunset

out_put=~/log/nmapA_list_color.html

echo "<html>
<body bgcolor=#351c4d text=#f5ab99>
<font face='Monospace'>" > $out_put

#<div style="background-color:lightblue">


key1="Nmap scan report for*."
style1="color=#FF7E5F"

key2="PORT STATE SERVICE VERSION*."
style2="color=#FF7E5F"

key3="^[0-9][0-9]*."
style2="color=#FF7E5F"


cat ~/log/nmapA_list.txt |
       	sed "s/</\&lt;/g" |
	sed "s/>/\&gt;/g" |
	sed "s/$/<br>/g" |
	sed -e "s/^Nmap.*\()<br>$\|[0-9]<br>$\)/<font color='#FF7E5F'><b>&<\/b><\/font>/g" |
	sed "s/^PORT.*VERSION<br>$/<font color='#FF7E5F'><b>&<\/b><\/font>/g" |
	sed "s/^MAC.*)<br>$/<font color='#FEB47B'><b>&<\/b><\/font>/g" |
	sed "s/^[0-9][0-9].*\/.*<br>$/<font color='#FF7E5F'>&<\/font>/g" 	>> ${out_put}

       	
echo "</xmp>" >> $out_put
