function New-SDPHostMapping {
    param(
        [parameter()]
        [string] $hostName,
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('pipeName')]
        [string] $volumeName,
        [parameter()]
        [string] $snapshotName,
        [parameter()]
        [string] $hostGroupName,
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
        
        if ($hostGroupName) {
                $hostGroupid = Get-SDPHostGroup -name $hostGroupName
                $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "host_groups" -ObjectID $hostGroupid.id -nestedObject
            } elseif ($hostName) {
                $hostid = Get-SDPHost -name $hostName
                $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "hosts" -ObjectID $hostid.id -nestedObject
        }

        if ($volumeName) {
            $volumeid = Get-SDPVolume -name $volumeName
            $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "volumes" -ObjectID $volumeid.id -nestedObject
        } elseif ($snapshotName) {
            $volumeid = Get-SDPVolumeSnapshot -name $snapshotName
            $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "snapshots" -ObjectID $volumeid.id -nestedObject
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

        $results = Get-SDPHostMapping -volumeName $volumeName
        while (!$results) {
            Write-Verbose " --> Waiting on host mapping for $volumeName"
            $results = Get-SDPHostMapping -volumeName $volumeName
            Start-Sleep 1
        }

        return $results
        
    }
}
