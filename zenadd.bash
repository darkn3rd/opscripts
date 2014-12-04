#!/bin/bash

usage ()
{
	echo "Usage:"
	echo "  $0 host device_path"
	exit 1
}

[[ $# -lt 2 ]] && usage

DEVICENAME=$1
DEVICEPATH=$2

curl -u admin:zenoss \
	"http://mon.sf.verticalresponse.com:8080/zport/dmd/DeviceLoader?deviceName=${DEVICENAME}&devicePath=${DEVICEPATH}&zSnmpCommunity=vertical&loadDevice:method=1" > /dev/null 2>&1 &


