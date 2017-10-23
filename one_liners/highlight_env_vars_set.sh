#!/bin/sh
# Highlights any ENV vars set that are also in .env.
# Requires: GNU GREP
#  Mac OS X: `brew install grep --with-default-names`
for E in $(cat .env | cut -d= -f1); do eval echo $E=\$$E; done | grep -P --color '(?<==)[^=]*$'
