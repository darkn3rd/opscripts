#!/bin/sh
for FILE in *.groovy; do sed -E 's:^#!/usr/bin/groovy$:#!/usr/bin/env groovy:' $FILE > tmp; mv tmp $FILE; done 
