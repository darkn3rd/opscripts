
# **Joaquin's Chef DevOps Box**

## **Package Manager**
### **HomeBrew**
**DISCLAIMER**: These instructions are tested with [Homebrew](http://brew.sh/), alternatively you can use [MacPorts](https://www.macports.org/).

Installation:
```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

This should change the `/etc/paths/` to look like this on Yomsemite (OS X 10.10) with `/usr/local/bin` at the front:
```bash
/usr/local/bin
/usr/bin
/bin
/usr/sbin
/sbin
```

### **Cask**
[Cask](http://caskroom.io/) is an optional package manager add-on to Homebrew for installations of  full applications (not just command-line tools).

```bash
$ brew install caskroom/cask/brew-cask
```

Installing some Applications

```bash
$ brew cask install google-chrome
$ brew cask install firefox
$ brew cask install atom
$ brew cask install hipchat
$ brew cask install lastpass
```

## **Shell Startup Environment**
Apple's *Terminal.app*, every new window starts bash in login shell mode, and so will look for these files in this order:  ① `~/.bash_profile`, ② `~/.bash_login`, and  ③`~/.profile` and source one of these.    If you launch a new shell session from within an existing Terminal window, `~/.bashrc` is called instead.

Typically, you can have `~/.bash_profile` source `~/.bashrc`:
```bash

[[ -s ~/.bashrc ]] && source "$HOME/.bashrc"
```

## **BASH and GNU Tools**

### **GNU Tools (Awk, Bash, Sed)**
OS X has a mix of older BSD and GNU versions of popular tools.  You can install GNU variety of Sed, and a recent version of Gawk.

```bash
$ brew install gnu-sed --with-default-name
$ brew install gawk
```
### **Latest Bash**
**PREREQUISITE** GNU Sed must be installed to do inline edits.

A more recent version of BASH (Bourne Again Shell) as the default shell:

```bash
$ brew install bash
$ /usr/local/opt/gnu-sed/bin/sed
$ sudo sed -i 's|/bin/bash|/usr/local/bin/bash|' /etc/shells
```

Use a similar process for ZShell as an alternative.

## **Language Platforms**
### **Installing Java JDK**

You can get Java 7 and Java 8 using Cask, or manually download and install them from [Oracle's website](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

```bash
$ brew cask install caskroom/versions/java7
$ brew cask install caskroom/versions/java8
```

### **Switching Java Versions**
Add this script snippet to your startup environment, then after you can easily switch between Java 7 and Java 8.

```bash
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
```

After you can simply use `setjdk 1.7` or `setjdk 1.8` to switch between the two.

### **Node**
Node environment using Homebrew
```bash
$ brew install node
$ npm -g install nvm
```

### **Ruby**

```bash 
$ brew install ruby
```

#### **Ruby Version Manager**
You can also use the ruby that comes with ChefDK, or use something like RVM to manage Rubies:

```bash
$ brew install gpg
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ curl -L https://get.rvm.io | bash -s stable --autolibs=homebrew
$ source $HOME/.rvm/scripts/rvm
$ rvm install 2.1.6
$ rvm use 2.1.6 --default
$ gem install bundler
```

### **Python**
Python environments.
```bash 
$ brew install python
$ brew install python3
```

## **Ops Environment**

### **SSH Keys**

*Adding stuff later*

#### **SSH Config for Jump Servers**

*Adding stuff later, Important*

### **ChefDK**
You can grab ChefDK from the source (https://downloads.chef.io/chef-dk/) or install it locally with cask `brew cask install chefdk`.

#### **Configuration**

#####**Prerequisites**

You are going to need an account on *The LDAP* with the appropriate group membership, and then link a new the account on *The Chef Server*.  (Note: *The Chef Server* needs to be able to access *The LDAP server* or its replicant, or this process will fail).  Once you setup an account, download the SSH PEM key.  Also, get the *validation key*, *jenkins key*, and the *provisioning key* from fellow team members that have access to these resources.

##### **Knife**

You can run `knife configure` or just create your own `~/.chef/knife.rb` file:

```ruby
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "first_last"
client_key               "#{current_dir}/dev-first_last.pem"
validation_client_name   "ops-dev-validator"
validation_key           "#{current_dir}/ops-dev-validator.pem"
chef_server_url          "https://ops-dev-chef.ops.appdynamics.com/organizations/ops-dev"
cookbook_path            ["#{current_dir}/../path/to/chef-repo/cookbooks"]
chef_repo_path           ["#{current_dir}/../path/to/chef-repo"]
```

#### **Ruby Environment**
You can use ruby that comes with the system or a packagemanager like Homebrew, or ruby managers like RVM or rbenv.  But they may not have all the gem libraries needed at their correct versions.  Optionally, you can use the ruby environment that comes with ChefDK.  

An environment that you can copy and past into your startup environment can be generated using `chef shell-init`.  This was generated, and edited (using `${HOME}` or `${PATH}` where appropriate to reduce clutter):

```bash
export PATH="/opt/chefdk/bin:${HOME}/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:${PATH}"

export GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
export GEM_HOME="${HOME}/.chefdk/gem/ruby/2.1.0"
export GEM_PATH="${HOME}/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
_chef_comp() {
    local COMMANDS="exec env gem generate shell-init install update push push-archive show-policy diff provision export clean-policy-revisions clean-policy-cookbooks delete-policy-group delete-policy undelete verify"
    COMPREPLY=($(compgen -W "$COMMANDS" -- ${COMP_WORDS[COMP_CWORD]} ))
}
complete -F _chef_comp chef
```

## **Dev Environment**
The Engineering Day one has the material needed for this environment.  These are minor optimizations, given that some tools are already installed.

### **Tools**
```bash 
$ brew install git
$ sudo gem install sass
$ brew install ant
$ brew cask install intellij-idea-ce
```

#### **DiffMerge**
Grab the latest DiffMerge Package installer from https://sourcegear.com/diffmerge/downloaded.php.   Version 4.2.0 can be downloaded with curl:

```bash
$ cd ~/Downloads
$ curl -O http://download-us.sourcegear.com/DiffMerge/4.2.0/DiffMerge.4.2.0.697.intel.stable.pkg
$ sudo installer -pkg ~/Downloads/DiffMerge.4.2.0.697.intel.stable.pkg -target /
```

### **Git Configuration**
There's some documentation in the slides on configuring `~/.gitconfig` configuration file.  Here's a sample:

```ini
[user]
	name = John Smith
	email = john.smith@appdynamics.com
[branch]
	autosetuprebase = always
[log]
	date = local
[color]
	branch = auto
	diff = auto
	status = auto
	ui = auto
[color "branch"]
	current = yellow reverse
	local = yellow
	remote = green
[color "diff"]
	meta = yellow
	frag = magenta
	old = red
	new = cyan
[color "status"]
	added = yellow
	changed = green
	untracked = cyan
[merge]
	tool = diffmerge
[alias]
	slog = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
[diff]
	tool = diffmerge
[difftool "diffmerge"]
	cmd = diffmerge \"$LOCAL\" \"$REMOTE\"
[mergetool "diffmerge"]
	cmd = "diffmerge --merge --result=\"$MERGED\" \"$LOCAL\" \"$(if test -f \"$BASE\"; then echo \"$BASE\"; else echo \"$LOCAL\"; fi)\" \"$REMOTE\""
	trustExitCode = true
```

## **Good Reads**

* **Bash Profiles** - http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
* **GNU Alternative Tools with Homebrew** - https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/

