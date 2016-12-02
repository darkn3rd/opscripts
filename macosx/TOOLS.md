# Notes on Popular Tools


## **AWS CLI Tools**

```bash
sudo -H pip install awscli --ignore-installed six
mkdir ${HOME}/.aws

cat <<-CFG_EOF >> ${HOME}/.aws/config
[default]
region=us-west-2
output=json

[gobalto-ng]
region=us-west-2
CFG_EOF

cat <<-CRED_EOF >> ${HOME}/.aws/credentials
[default]
aws_access_key_id = REDACTED
aws_secret_access_key = REDACTED

[account_1]
aws_access_key_id = REDACTED
aws_secret_access_key = REDACTED

[account_2]
aws_access_key_id = REDACTED
aws_secret_access_key = REDACTED
CRED_EOF
```


## **Scripting**

For the power scripter you want to get the following tools on any system:

    Tools: GNU Awk, GNU Sed
    Shells: Bash 4
    Scripting Languages: Perl, Python, Ruby
    Other: Node platform, Java Platform

### **Node (latest stable)**

``` bash
# fetch latest stable (Node 7 on 2016-nov)
brew install node
npm install -g npm@latest
# list installed global modules
npm -g ls --depth=0
```

### **Install from NVM**

NVM is a version manager for installing different versions of node.  You can install node on a per user bases for your projects.

```bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
source "$HOME/.nvm/nvm.sh"
# install desired version
nvm install 4.6
# list installed global modules
npm install -g npm@latest
# install example modules
npm install -g bower grunt-cli
```

### **Ruby**

This installs an overall system ruby.
```bash
# fetch latest stable (Ruby 2.3.3 on 2016-nov)
brew install ruby
```

### **Ruby from RVM**

RVM is a version manager for installing different versions of ruby.  You can install ruby on a per user bases for your projects.

```bash
brew install gpg
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source "$HOME/.rvm/scripts/rvm"
# list available rubies
rvm list known
# install a ruby version
rvm install ruby-2.0.0-p648
rvm install ruby-2.3
# select your default ruby
rvm --default use ruby-2.3
```

Post Install Configurations

```bash
# install package manager
gem install bundler
# list local gems
gem list
```

#### **RVM on Project Basis**

```bash
$ printf "%s\n" $(cat .ruby-version)
ruby-2.0.0-p648
$ printf "%s\n" $(cat .ruby-gemset)
snoopy
$ rvm current
ruby-2.0.0-p648@snoopy
```

#### **RVM Startup Configuration**

```bash
### .bash_profile
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
```

```bash
### .bashrc
# If RVM Not Installed
[ -z $(which rvm) ] || export PATH="$PATH:$HOME/.rvm/bin"
[ -z $(echo ${rvm_path}) ] && [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
```

### **Perl 5**

```bash
# Install Perl latest stable
brew install perl
# Setup Environment
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bash_profile
# Install Modules in current environment
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
# Install Package Manager Wrapper
brew install cpanminus
# Install Perl Modules Example
cpanm YAML::XS
```

### **Python 2**

```bash
# Mac OS X (Darwin)
brew install python
pip install --upgrade pip setuptools
brew linkapps python
pip install virtualenvwrapper
# list installed modules
pip list --format=legacy
```


### **Python 3**

```bash
# Mac OS X (Darwin) only
brew install python3
pip3 install --upgrade pip setuptools wheel
# List installed modules
pip3 list --format=columns
```

### **Vagrant**

Vagrant automates virtual machine management and provisioning.

**Use Cases**

Vagrant is great for meta-tooling, building tools that will work on AWS or in a Docker container, developing change config scripts, build scripts, deploy scripts, and so forth.


**DISCLAIMER** It seems that each iteration of Vagrant is broke in some way, so you may want to install manually, as Brew/Cask does not support installing a particular version.

```bash
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vagrant
# ONLY 1.8.7 - Total Hack, Don't recommend
sudo ln -nsf /usr/bin/curl /opt/vagrant/embedded/bin/curl
```

### **Docker Notes**

```bash
# get a tree to verify images
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz images -t
# kill all running containers
docker ps -q | xargs docker kill
# delete all docker images on the system (nuclear option)
docker images -q | xargs docker rmi
```
