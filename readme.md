# Kaminario K2 PowerShell SDK 

### Installation 
For now, clone this repo and import the module manually via:
```
Import-Module ./path/k2rf.psm1
```

### Example usage:

This module requires Powershell 4.x or above and was developed on PowerShell Core Preview 7. 
After importing, you can connect to the Kaminario K2 appliance using a conventional PowerSHell credntial object
```powershell
$creds = get-credential
Connect-K2RF -Server 10.10.47.15 -Credentials $cred
```

You can then use the functions in the module manifest to perform the desired operations. 
```Powershell
Get-K2RFEvents -EventId 28 -user admin
```
