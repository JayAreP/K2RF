# Silk Data Platform (formerly Kaminario) PowerShell SDK 
## Experimental, do not use in production deployments!

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
# Gather events specific to the desired query. 
Get-SDPEvents -EventId 28 -user admin

# Quickly gather the hosts for a desired host group
Get-SDPHostGroup -name TestDemo | Get-SDPHost

# Move volumes from VolumeGroup TestSRC to TestDST
Get-SDPVolumeGroup -name TestSRC | Get-SDPVolume | Set-SDPVolume -volumeGroupName TestDST
```

Specify -Verbose on any cmdlet to see the entire API process, including endoint declarations, and json statements. You can use this to help model API calls directly or troubleshoot. 
