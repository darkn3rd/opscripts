
# **NOTES**

## **STEPS**

### **1. Create Deployment Share**

```powershell
# MDT 2013 on Win2012r2
New-Item -Path "C:\DeploymentShare" -ItemType directory
New-SmbShare -Name "DeploymentShare$" -Path "C:\DeploymentShare" -FullAccess Administrators
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
new-PSDrive -Name "DS001" -PSProvider "MDTProvider" -Root "C:\DeploymentShare" -Description "MDT Deployment Share" -NetworkPath "\\MDT01\DeploymentShare$" -Verbose | add-MDTPersistentDrive -Verbose
```

### **2. Configure Properties on Deployment Share**

#### **Edit Rules**

```ini
[Default]
OSInstall=Y
SkipCapture=NO
SkipAdminPassword=NO
SkipProductKey=YES
SkipComputerBackup=YES
SkipBitLocker=YES

SkipWizard=NO
SkipAppsOnUpgrade=NO
SkipDeploymentType=NO
SkipComputerName=NO
SkipDomainMembership=NO
SkipUserData=NO
SkipComputerBackup=NO
SkipTaskSequence=NO
SkipProductKey=NO
SkipPackageDisplay=NO
SkipLocaleSelection=NO
SkipTimeZone=NO
SkipApplications=NO
SkipAdminPassword=NO
SkipCapture=NO
SkipSummary=NO
SkipFinalSummary=NO
SkipCredentials=NO
SkipRoles=NO
SkipBDDWelcome=NO
```

#### **Edit Windows PE Settings**

May want to select x64, as default is x86

### **3. Update Deployment Share**

After making any changes, you'll need to update the DeploymentShare.

```powershell
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "C:\DeploymentShare"
update-MDTDeploymentShare -path "DS001:" -Verbose
```

### **4. Import An Operating System**


#### **Create Folder**

```
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "C:\DeploymentShare"
new-item -path "DS001:\Operating Systems" -enable "True" -Name "Win2012r2" -Comments "" -ItemType "folder" -Verbose
```

#### **Import Operating Systems from Source CD**

```powershell
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "C:\DeploymentShare"
import-mdtoperatingsystem -path "DS001:\Operating Systems\Win2012r2" -SourcePath "D:\" -DestinationFolder "Windows 2012r2 x64" -Verbose
import-mdtoperatingsystem -path "DS001:\Operating Systems\Win8" -SourcePath "D:\" -DestinationFolder "Windows 8 Enterprise Evaluation Technical Preview x64" -Verbose
import-mdtoperatingsystem -path "DS001:\Operating Systems\win10" -SourcePath "D:\" -DestinationFolder "Windows 10 Enterprise Evaluation Technical Preview x64" -Verbose
```


### **5. Drivers**




```powershell
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "C:\DeploymentShare"
new-item -path "DS001:\Out-of-Box Drivers" -enable "True" -Name "gigabyte_brix" -Comments "" -ItemType "folder" -Verbose
```
#### **Import from Driver CD**

```
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "C:\DeploymentShare"
import-mdtdriver -path "DS001:\Out-of-Box Drivers\gigabyte_brix" -SourcePath "D:\" -Verbose
```
