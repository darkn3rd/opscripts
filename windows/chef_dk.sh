# Place this in .bash_profile

# CygWin version of Window Variables
export WINDIR="/cygdrive/c/Windows/"
export USERPROFILE="/cygdrive/c/Users/${USERNAME}"
# Custome Variable
SYSTEM32="${WINDIR}/system32"

# Common Paths
WINPATHS="${SYSTEM32}:${WINDIR}:${SYSTEM32}/Wbem:${SYSTEM32}/WindowsPowerShell/v1.0"
VAGRANTPATH="/cygdrive/c/HashiCorp/Vagrant/bin"
CHEFDKPATH="/cygdrive/c/opscode/chefdk/bin"
ATOMPATH="${USERPROFILE}/AppData/Local/atom/bin"

# Reset Path
export PATH="/usr/local/bin:/usr/bin:${WINPATHS}:${VAGRANTPATH}:${CHEFDKPATH}:${ATOMPATH}"

# CygWin or DOS Path used with Aliases
CHEFDK_RUBY="/cygdrive/c/opscode/chefdk/embedded/bin/ruby"
CHEFDK_DOSPATH="C:/opscode/chefdk/bin"
# Aliases to launch/Run Common ChefDK tools (Wrapper Aliases)
#  Note: Shell Scripts shebang lines have DOS pathnames,
#        which MSYS auto-translates, CYGWIN does not.
alias knife="${CHEFDK_RUBY} ${CHEFDK_DOSPATH}/knife"
alias chef-client="${CHEFDK_RUBY} ${CHEFDK_DOSPATH}/chef-client"
alias chef-solo="${CHEFDK_RUBY}  ${CHEFDK_DOSPATH}/chef-solo"
alias shef="${CHEFDK_RUBY}  ${CHEFDK_DOSPATH}/shef"
alias chef="${CHEFDK_RUBY}  ${CHEFDK_DOSPATH}/chef"
