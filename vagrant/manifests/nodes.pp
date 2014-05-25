# Production

node default {

}

# This is a base class that includes basics for all servers.
node base {
  include motd, ldapclient, sudoers, ssh, users, groups, resolveconf, snmp

  ### Defining the Current Ruby Version in Staging Environments  #########
  ### These variables need to change if Ruby is upgraded         #########
  $ruby_version = "2.0.0-p353"
  $ruby_patch = "2.0.0p353"

}

node mynode inherits base { include vagrant }

