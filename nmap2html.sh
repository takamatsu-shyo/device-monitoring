#!/bin/bash
# This script execute 3 scripts so that you only need set one cron job

/bin/bash $HOME/device-monitoring/nmap_all_parallel.sh
echo "Done: nmap all"

/bin/bash $HOME/device-monitoring/gen_contents.sh
echo "Done: gen contents"

/bin/bash $HOME/device-monitoring/edit_html.sh
echo "Done: edit html"

