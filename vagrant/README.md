# Puppet-Dev Notes - vagrant + contoso-puppet

This is a ficticious company Contoso, and uses a ficticious repository called contoso-puppet. 

Contoso has puppet modules that implement ssh, sudoers,  users, and groups, which conflict with Vagrant.  A vagrant helper class is copied locally, as it would normally be in the ficticious contoso-puppet.

Contoso has different environments configured on the PuppetMaster, which are ops, staging, and production.  There are modules configured for each environment, as well as global common modules shared by all environments.  The Vagrantfile included, is configured to use production environment from the contoso-puppet git repo.

You will need to fetch VirtualBox and Vagrant before running these instructions:

  * VirtualBox -  https://www.virtualbox.org/wiki/Downloads 
  * Vagrant - https://www.vagrantup.com/downloads.html

1. Create a local directory for our puppet-dev environment

 ```mkdir ~/puppet-dev```

2. Copy Vagrantfile from opscripts to local puppet-dev

 ```cp /path/to/opscripts/vagrant/Vagrantfile.prd_local.rb ~/puppet-dev/Vagrantfile```

3. Create a local link in your vagrant directoy to contoso-puppet repo.

 ```ln -s /path/to/contoso-puppet ~/puppet-dev/to/contoso-puppet```

4. Create local manifests

 ```# copy from opscripts or create your own
 mkdir ~/vagrant_manifests
 cp /path/to/opscripts/vagrant/manifests/* ~/vagrant_manifests

 # make local link
 ln -s ~/vagrant_manifests ~/puppet-dev/local_manifests```

5. Edit Node

The Vagrantfile configured a hostname, which is currently set to "mynode".  This should match a node specified in your nodes.pp file.

6. Launch and Provision

  ```# type this in your ~/puppet-dev directory
  vagrant up
  vagrant ssh```

7. Provision Again as needed

 Once you make code changes, you can test them out by doing the following:

  ```vagrant provision```

8. Root vs. Vagrant

 During the first run of vagrant, you absolutely need to use root, which the Vagrantfile is configured to do already. Afterwards, you can comment out those two lines, which will then use the default vagrant user.  The reason is that initially, out of the box, vagrant has a uid=500, and in our environment, vr has a uid=500.  The user vagrant cannot change it's uid, so you have to use root to do this on the initial provision, then switch back to the default.

 These are the two lines that can be commented out:

   ```config.ssh.username = "root"
   config.ssh.password = "vagrant"```

 With the default back to vagrant/vagrant, you can use the command:

   ```vagrant ssh```

 This command will do the equivelent of the following:

   ```ssh -i $(vagrant ssh-config | grep IdentityFile  | awk '{print $2}') -l root -p 2222 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 127.0.0.1```
