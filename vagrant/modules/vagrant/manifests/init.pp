# == Class: vagrant
#
# Vagrant Helper Class - modifies vagrant virtual system for compatibility
#  with VR's infrastructure, e.g. change vagrant user id 500 to 
#  something else
#
# === Authors
#
# Author Name <jmenchaca@verticalresponse.com>
#
# === Copyright
#
# Copyright 2014 Joaquin Menchaca.
#
class vagrant {
  
  # modify vagrant BEFORE users module runs
  #  to avoid conflicts on uid=500
  user { 'vagrant':
    uid     => "555",
    gid     => "555",
    before  => Class['users'],
    require => Group['vagrant'],
  }

  # add vagrant group
  group { 'vagrant': gid => "555" }

  # add vagrant to wheel
  group { 'wheel': members => ['vagrant'] }
  
  # add sudoers entry for vagrant AFTER running Contoso's sudoers module
  augeas { 'sudovagrant':
    context => '/files/etc/sudoers',
    changes => [
       'set spec[user = "vagrant"]/user vagrant',
       'set spec[user = "vagrant"]/host_group/host ALL',
       'set spec[user = "vagrant"]/host_group/command ALL',
       'set spec[user = "vagrant"]/host_group/command/runas_user ALL',
       'set spec[user = "vagrant"]/host_group/command/tag NOPASSWD',
    ],
    require => Class['sudoers'],
  }
  
  # convenience function, enable root in case there is problem
  #  Notes: 
  #  Contoso's policy is that:
  #   1. Root cannot ssh into system, security risk
  #  Vagrant's policy is that:    
  #   2. Key's are used authenticate, no password.
  #  This makes an excption, to allow root access in case vagrant 
  #  account made inoperable by Contoso's user/groups/sudoer config
  augeas { 'sshdvagrant':
    context => '/files/etc/ssh/sshd_config', 
    changes => [
       'set PermitRootLogin yes',
       'set ChallengeResponseAuthentication yes'
    ],
    require => Class['ssh']
  }
  
  # copy auto-generated public key to keys directory
  # Note: 
  #  - Assumption that vagrant is used from a Linux/Unix user account
  #  - This will run after Contoso's ssh class
  exec { 'sshdvagrant': 
     command => '/bin/cp ~vagrant/.ssh/authorized_keys /etc/ssh/keys/vagrant.pub',
     require => Class['ssh']
  }
  
  # Change permissions on newly installed Vagrant pub key 
  file { '/etc/ssh/keys/vagrant.pub': 
    mode => 644,
    require => Exec['sshdvagrant'] 
  }

}
