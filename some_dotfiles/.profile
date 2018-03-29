
export SHELLPROFILE="${SHELLPROFILE}:profile"

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# AppD codebase basics
PATH=${PATH}:"$HOME/workarea/codebase/":"$HOME/workarea/codebase/tools/":"$HOME/bin/"
export ANT_OPTS='-Dstart-glassfish-in-debug-mode=true'
export GRADLE_OPTS='-Dstart-glassfish-in-debug-mode=true -Dorg.gradle.daemon=true -Dorg.gradle.configureondemand=true'

#PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
#alias ls="ls --color"
#PATH="$(brew --prefix coreutils)/libexec/gnubin

PATH="/usr/local/sbin:${PATH}"

### RVM STUFF ###############
rvm_mode() {
  Add RVM to PATH for scripting
  export PATH="$PATH:$HOME/.rvm/bin"
  # Load RVM into a shell session *as a function*
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
}

### CHEFDK STUFF ###############
chef_mode() {
  export PATH="/opt/chefdk/bin:${HOME}/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/embedded/bin:${PATH}"
  export GEM_ROOT="/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
  export GEM_HOME="${HOME}/.chefdk/gem/ruby/2.1.0"
  export GEM_PATH="${HOME}/.chefdk/gem/ruby/2.1.0:/opt/chefdk/embedded/lib/ruby/gems/2.1.0"
  _chef_comp() {
      local COMMANDS="exec env gem generate shell-init install update push push-archive show-policy diff provision export clean-policy-revisions clean-policy-cookbooks delete-policy-group delete-policy undelete verify"
      COMPREPLY=($(compgen -W "$COMMANDS" -- ${COMP_WORDS[COMP_CWORD]} ))
  }
  complete -F _chef_comp chef
}

### CHOOSE YOUR RUBY STUFF ###############
ruby_mode() {
  case "$1" in
    "chef")
      chef_mode
      ;;
    "rvm")
      rvm_mode
      ;;
  esac
}

export PATH
