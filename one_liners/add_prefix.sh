#!/bin/sh
# prepend it. to every file
for FILE in *;do mv ${FILE} it.${FILE}; done
