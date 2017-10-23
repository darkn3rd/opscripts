# Prereq: NVM should be installed previously (2016-01)
nvm_environment() {
  export NVM_DIR="${HOME}/.nvm"
  [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm
}
