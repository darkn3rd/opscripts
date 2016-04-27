#!/usr/bin/env bash

####### BREW BUNDLE SOME AWESOMENESS
brew tap Homebrew/bundle
brew bundle

####### PYTHON ESSENTIAL STUFF
brew linkapps 'python'
pip install --upgrade pip setuptools
pip install virtualenvwrapper

####### PYTHON PACKAGES
sudo -H pip install ansible          # Ansible Change Configuration Tools
sudo -H pip install salt             # Salt Change Configuration Tools
sudo -H pip install awscli           # AWS Command Line Tools

####### RUBY GEMS
gem install bundler rake nori inifile sqlite3

####### NODE MODULES
npm -g install grunt mocha bower
npm -g install typescript coffee-script

####### SCISSOR IN BASH4 AS BASH INTERPRETER
# Note: Requires GNU Sed (above) for inline edits (NOT SUPPORTED IN BSD SED)
sudo sed -E -i 's#(/bin/bash)#/usr/local\1#' /etc/shells

####### COLORS ARE PURDY
cat <<-EOF >> ${HOME}/.bash_profile
  # Prompt Dressing
  export CLICOLOR=1
  export LSCOLORS=GxFxCxDxBxegedabagaced
  export TERM="xterm-color"
  export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '
EOF
