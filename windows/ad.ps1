Import-Module ActiveDirectory
#To query Unix Properties of a User Object
$username = "guest"
Get-ADUser $username -Properties * | Select SamAccountName, msSFU30NisDomain,uidNumber, unixHomeDirectory, loginShell,gidnumber, @{Label='PrimaryGroupDN';Expression={(Get-ADGroup -Filter {GIDNUMBER -eq $_.gidnumber}).SamAccountName}}
#To query Unix Properties of a Group object
$groupname = "Unix Sample Group"
Get-ADGroup $groupname -Properties * | Select SamAccountName, msSFU30NisDomain,gidnumber, @{Label='Members';Expression={(Get-ADUser -Filter {GIDNUMBER -eq $_.gidnumber}).SamAccountName}}
#To query Unix Properties of a Computer Object
$computername = "server123"
Get-ADComputer $computername -Properties * | Select SamAccountName, msSFU30NisDomain,ipHostNumber, msSFU30Aliases
#Set unixHomeDirectory on a user (replace this with any of the attributes you’d like to set)
$username = "guest"
set-ADUser $username -Replace @{unixHomeDirectory="/usr/sbin/guest"}
