#!/bin/bash
# This script execute 3 scripts so that you only need set a cron job

/bin/bash $HOME/device-monitoring/get_list.sh
echo "Done: nmap -sn"

/bin/bash $HOME/device-monitoring/summary.sh
echo "Done: gen contents"

/bin/bash $HOME/device-monitoring/gen_contents.sh
echo "Done: gen contents"

/bin/bash $HOME/device-monitoring/edit_html.sh
echo "Done: edit html"

