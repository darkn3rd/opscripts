#!/bin/sh
for f in *; do tr -d '\15\32' < $f > tmp; mv tmp $f; done
