#!/bin/sh
sudo mkdir /private/var/db/lsd
sudo touch /private/var/db/lsd/com.apple.lsdschemes.plist
sudo chown -R root:wheel  /private/var/db/lsd
sudo chmod -R 777 /private/var/db/lsd
xattr -wr com.apple.finder.copy.source.checksum#N 4 /private/var/db/lsd
xattr -wr com.apple.metadata:_kTimeMachineNewestSnapshot 50 /private/var/db/lsd
xattr -wr com.apple.metadata:_kTimeMachineOldestSnapshot 50 /private/var/db/lsd
sudo killall -9 lsd
