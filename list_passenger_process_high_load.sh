#!/bin/bash

# This script prints hash tags for every passenger process 
# that consumes more than 90% of cpu.
#    by Joaquin Menchaca, May 2014

# build list of servers
eval systems=\" srv-app0{1..5}.yourcompany.com \"

systems=$(echo $systems | sort)

read -r -d '' cmds <<-'COMMANDS'
   HOSTNAME=$(hostname | cut -d. -f1);
   HIGH_LOAD_NUM=$(ps -U deploy -o %cpu=,pid=|awk '{if ($1 > 90) {print $2}}' | wc -l);
   printf '  %-10s: ' ${HOSTNAME}; printf '#%.0s' $(seq 0 ${HIGH_LOAD_NUM})|sed 's/^.//'; echo
COMMANDS

echo "Number of Processes Consuming More than 90%"
echo "==========================================="

for system in $systems; do
  ssh opsadm@$system $cmds
done

