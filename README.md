# nmap script with cron
Monitoring devices in local network continuously.   
Idea; nmap shell script with cron job 

# Requirements
- nmap
- sudo, cron, smtp 

# How to use
- Change IP address range at get_list.sh
Set crontab -e for scripts. For example,    
get_list.sh / IP address table / every 5 minutes 
summary.sh  / IP and MAC address table / every 5 minutes
nmapA2html.sh / nmap -A for all IP address / onece every hour

# TODO
- Log rotate
- Distributed system with multiple servers?
- Corporate with attacker node

# Tested OS
- Raspbian
- Aarch Linux ARM
