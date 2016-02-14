# Changing to Private Network

Windows 8 - 10 and Windows 2012, you cannot change your network connection profile.  So when you are on a private network, and Windows is pegged to Public network, you can never use things like remote management.

## Steps to Correct

Under Windows 2012

### Server Manager

* In "Server Manager" open the "Tools" menu and select "Local Security policy".

### Local Security Policy

* Select "Network List manager policies" in the console tree.
* Open "All Networks" properties.
* Change "Network location" to "User can change location"
* Now reboot to apply the changes.

### PowerShell

```PowerShell
# Get InterfaceIndex - don't know how to get only one value from table, taking too long to figure out
Get-NetConnectionProfile | Select InterfaceIndex
# Change it, manually replacing $InterfaceIndex with appropriate value
Set-NetConnectionProfile -InterfaceIndex $InterfaceIndex -NetworkCategory Private
```

## Source

* http://www.jenovarain.com/2012/09/server-2012-network-location/
