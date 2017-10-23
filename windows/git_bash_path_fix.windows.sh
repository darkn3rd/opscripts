#!/bin/sh
# convert DOS style %varibles% to UNIX style ${variables}
NEWPATH=$(echo "$PATH" | sed 's/%\([^%]*\)%/${\1}/g')
 
# resolve all variables in $PATH
eval NEWPATH=\"${NEWPATH}\"
 
# convert DOS paths (C:\path\) to UNIX paths (/c/path/)
PATH="$(echo "${NEWPATH}" | sed \
   -e 's@^\([a-zA-Z]\):\\@/\L\1/@g' \
   -e 's@:\([a-zA-Z]\):\\@:/\L\1/@g' \
   -e 's@\\@/@g')"
 
export PATH
