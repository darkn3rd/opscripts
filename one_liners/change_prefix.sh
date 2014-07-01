#!/bin/sh
# change all the files that begin with l* to begin with m*
for FILE in l*;do mv ${FILE} m${FILE:1}; done
