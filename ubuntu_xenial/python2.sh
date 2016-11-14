#!/bin/sh
# Run as Root
apt install -y python-setuptools
easy_install pip
pip install --upgrade pip setuptools
pip install virtualenvwrapper
