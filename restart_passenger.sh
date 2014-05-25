#!/bin/bash

# This script accepts a string of numbers that represent 
# an server in a series.  It will then prompt the user if the 
# user wishes to bounce passenger.  
#
# Bouncing passenger invovles signaling a restart, then killing
# all the passenger RackApp processes.
#
#    by Joaquin Menchaca, May 2014

SYSTEMS=$(echo "$@" | sed 's/ //g' | sed 's/./& /g')
SYSTEMS=$(echo $SYSTEMS | tr ' ' "\n" | sort | uniq | tr "\n" " " )

read -r -d '' CMDS <<-'COMMANDS'
   sudo su -c "touch ~/current/tmp/restart.txt" -s /bin/bash deploy;
   kill -9 $(ps auxwww | grep RackApp | grep -v grep | awk '{print $2}')
COMMANDS

for SYSTEM in ${SYSTEMS}; do
  TARGET_SYSTEM=srv-app0${SYSTEM}.yourcompany.com
  read -p "Do you wish to restart passenger on $(echo ${TARGET_SYSTEM} | cut -d. -f1)? " yn
  case $yn in
      [Yy]* ) ssh opsadm@${TARGET_SYSTEM} ${CMDS}
  esac
done
