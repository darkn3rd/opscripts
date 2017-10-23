#!/bin/sh
awk '{out=$2; for(i=3;i<=NF;i++){out=out" "$i}; print out}'
