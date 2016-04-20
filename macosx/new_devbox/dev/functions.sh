#!/usr/bin/env bash

# DOCKER CONVENIENCE
function dsh      { docker exec -it $1 bash; }
function dgethash { docker ps -a | grep $1 | awk '{print $1}' ;}
function dkill    { docker kill $1; }
function drm      { docker rm $1; }
function de       { docker exec -it $*; }
function dmip     { docker-machine ip $1; }
function dmstop   { docker-machine stop $1; }
function dcup     { docker-machine up -d; }
function dcstop   { docker-machine stop $*; }
function dcrm     { docker-machine rm $*; }
function dcbuild  { docker-machine build $*; }

function dms {
  if ! docker-machine ls | grep -q deault; then
    docker-machine start default
    eval $(docker-machine env)
  fi
}

# VAGRANT CONVENIENCE
function vnp { vagrant up --no-provision $1; }
function vp  { vagrant provision $1; }
function vsh { vagrant ssh $1; }

# Prereq: Java 7 and/or Java 8 must be installed (2016-01)
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
   export CLASSPATH=$CLASSPATH:$HOME/Classes
  fi
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

function setaws {
  if [ $# -ne 0 ]; then
    export AWS_DEFAULT_PROFILE=$1
  fi
}

function getaws {
    echo AWS_DEFAULT_PROFILE=${AWS_DEFAULT_PROFILE}
}

# Prereq: NVM should be installed previously (2016-01)
function enableNVM() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

# Prereq: Maven should be installed `brew install maven` (2016-01)
function enableMVN() {
  export M2_HOME=/usr/local/Cellar/maven/3.3.9
  export MAVEN_OPTS="-Xms256m -Xmx512m"
  export M2=$M2_HOME/bin
  export PATH=$M2:$PATH
}

# ALIAS
alias v='ansible-vault --vault-password-file ~/.vaultpw '
