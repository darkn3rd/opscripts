#!/bin/sh

# Post Brew Installation
brew linkapps 'python'
pip install --upgrade pip setuptools
pip install virtualenvwrapper

# Other Tools
sudo -H pip install ansible          # Ansible Change Configuration Tools
sudo -H pip install salt             # Salt Change Configuration Tools
sudo -H pip install awscli           # AWS Command Line Tools
