#!/usr/bin/env bash

defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# sudo nvram SystemAudioVolume=" "
sudo nvram SystemAudioVolume=%80

# Prevent Gatekeeper Turning Back On Automatically in OS X
# http://osxdaily.com/2015/11/05/stop-gatekeeper-auto-rearm-mac-os-x/
sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool NO
