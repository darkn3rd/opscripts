export SHELLPROFILE="bash_profile"

### SELECT EXACT ENVIRONMENT ###################
[[ -s ~/.profile ]] && source "$HOME/.profile"
[[ -s ~/.bashrc ]] && source "$HOME/.bashrc"

## GLOBAL SETTINGS #############################

ruby_mode chef
setjdk 1.7
