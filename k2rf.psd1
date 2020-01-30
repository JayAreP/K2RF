@{
    RootModule = 'k2rf.psm1'
    ModuleVersion = '0.1'
    GUID = '095f49d6-e71d-4447-9820-ac74a8ea25ce'
    Author = 'J.R. Phillips'
    PowerShellVersion = '4.0'
    ScriptsToProcess = @()

    # FunctionsToExport = @('Connect-K2RF','Invoke-K2RFRestCall','Get-K2RFVolumeGroups','Get-K2RFEvents','Get-K2RFHostFcPorts')
    FunctionsToExport = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{
    
        PSData = @{
    
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = 'K2','Kaminario'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/JayAreP'
    
        }
    } 
}