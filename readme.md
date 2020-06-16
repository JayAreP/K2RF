# Silk Data Platform (formerly Kaminario) PowerShell SDK 
## Currently I consider this SDK experimental, and do not recommend use in production deployments without testing thoroughly.

### Installation 
For now, clone this repo and import the module manually via:
```
Import-Module ./path/SDP/sdp.psd1
```

Or, run the provided InstallSDP.ps1 script. 

### Example usage: 

This module requires Powershell 4.x or above and was developed on PowerShell Core Preview 7. 
After importing, you can connect to the Silk Data Platform or Kaminario K2 appliance using a conventional PowerShell credential object
```powershell
$creds = get-credential
Connect-SDP -Server 10.10.47.15 -Credentials $cred
```

You can then use the functions in the module manifest to perform the desired operations. 
```Powershell
# Gather events specific to the desired query:
Get-SDPEvents -EventId 28 -user admin

# Quickly gather the hosts for a desired host group:
Get-SDPHostGroup -name TestDemo | Get-SDPHost

# Create Host:
New-SDPHost -name Host01 -type Linux

# Create Volume Group:
New-SDPVolumeGroup -name VG01

# Create Volumes and add volumes to volume group:
New-SDPVolume -name Vol01 -sizeInGB 20 -volumeGroupname VG01
# or via pipe
Get-SDPVolumeGroup -name VG01 | New-SDPVolume -name Vol02 -sizeInGB 20

# Move volumes from VolumeGroup VG01 to VG02:
Get-SDPVolumeGroup -name VG01 | Get-SDPVolume | Set-SDPVolume -volumeGroupName VG02

# Add all volumes from a volume group to a host:
Get-SDPVolumeGroup -name VG01 | Get-SDPVolume | New-SDPHostMapping -hostName Host01
```

Specify -Verbose on any cmdlet to see the entire API process, including endoint declarations, and json statements. You can use this to help model API calls directly or troubleshoot. 
