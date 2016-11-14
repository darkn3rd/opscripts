# **Notes for Ubuntu 16.04 Xenial**

## **Base Versions**

* Scripting Engines
    * Python 2.7.12
    * Python3 3.5.2
    * Ruby 2.3.1p112
    * Perl 5.22.1
    * Bash 4.3.46
* Tools
    * awk - Mawk 1.3.3 (POSIX 1003.2 - draft 11.3)
    * bc 1.06.95
    * sed - GNU Sed 4.2.2
    * sh - Dash 0.5.8-2.1ubuntu2
    * vim 7.4
    * wget 1.17.1
* Tool Sets
    * GNU coreutils 8.2.5 - cut, env, expr, sort, tr
    * GNU findutils 4.7.0-git - find

## **Applications, Tools, and Environments**

### **Python 2 Environment**

Steps to install basic Python environment (minimalist path).
```bash
sudo apt install python-setuptools
sudo easy_install pip
sudo -H pip install --upgrade pip setuptools
sudo -H pip install virtualenvwrapper
```
### **Python 3 Environment**

```bash
sudo apt install -y python3-setuptools
sudo -H easy_install3 pip
sudo -H pip3 install --upgrade pip setuptools wheel
```

### **Ansible**

**Requirement:**: Python 2 Environment

```bash
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo -H pip install cryptography
sudo -H pip install ansible
```

## **Docker**

```bash
# Prerequites
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y apt-transport-https ca-certificates
# Variables for GPG key and Repo
KEY='58118E89F3A912897C070ADBF76221572C52609D'
KEYSRV='p80.pool.sks-keyservers.net'
SOURCE='deb https://apt.dockerproject.org/repo ubuntu-xenial main'
SRC_LIST='/etc/apt/sources.list.d/docker.list'
# Insert Key and Setup Remote REPO
sudo apt-key adv --keyserver hkp://${KEYSRV}:80 --recv-keys ${KEY}
sudo echo "${SOURCE}" | sudo tee ${SRC_LIST}
# Install Application
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install docker-engine
# Post Install Setup
sudo usermod -aG docker ${USER}
```

## **VirtualBox**

**Important Note**: Secure Boot ***MUST*** be turned off.

```bash
# Variables for GPG Key and Repo
SOURCE='deb http://download.virtualbox.org/virtualbox/debian xenial contrib'
SRC_LIST='/etc/apt/sources.list.d/virtualbox.list'
# Insert Key and Setup Remote REPO
sudo wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo echo ${SOURCE} > ${SRC_LIST}
# Install Application
sudo apt-get update
sudo apt-get install virtualbox-5.1
# Post install
sudo usermod -aG vboxusers ${USER}
```

## **Spotify**

```bash
# Variables for GPG Key and Repo
KEY='BBEBDCB318AD50EC6865090613B00F1FD2C19886'
KEYSRV='keyserver.ubuntu.com'
SOURCE='deb http://repository.spotify.com stable non-free'
SRC_LIST='/etc/apt/sources.list.d/spotify.list'
# Insert Key and Setup Remote REPO
sudo apt-key adv --keyserver hkp://${KEYSRV}:80 --recv-keys ${KEY}
sudo echo ${SOURCE}| sudo tee ${SRC_LIST}
# Install Application
sudo apt-get update
sudo apt-get -y install spotify-client
```
