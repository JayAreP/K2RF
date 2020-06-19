function New-SDPHostMapping {
    param(
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('pipeName')]
        [string] $hostName,
        [parameter()]
        [string] $volumeName,
        [parameter()]
        [string] $snapshotName,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    <#
        .SYNOPSIS

        .EXAMPLE 

        .DESCRIPTION

        .NOTES
        Authored by J.R. Phillips (GitHub: JayAreP)

        .LINK
        https://www.github.com/JayAreP/K2RF/

    #>
    begin {
        $endpoint = 'mappings'
    }

    process{
        ## Special Ops
        
        $hostid = Get-SDPHost -name $hostName
        $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "hosts" -ObjectID $hostid.id -nestedObject

        if ($hostid.host_group) {
            $message = "Host $hostName is a member of a host group, please use New-SDPHostGroupMapping for the parent group or select an ungrouped host."
            Write-Error $message
        }

        if ($volumeName) {
            $volumeid = Get-SDPVolume -name $volumeName
            $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "volumes" -ObjectID $volumeid.id -nestedObject
        } elseif ($snapshotName) {
            $volumeid = Get-SDPVolumeGroupSnapshot -name $snapshotName
            $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "snapshots" -ObjectID $volumeid.id -nestedObject
        } else {
            $message = "Please supply either a -volumeName or -snapshotName"
            return $message | Write-error
        }

        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "host" -Value $hostPath
        $o | Add-Member -MemberType NoteProperty -Name "volume" -Value $volumePath

        $body = $o

        ## Make the call
        try {
            Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context -erroraction silentlycontinue
        } catch {
            return $Error[0]
        }

        return $body
        
    }
}
