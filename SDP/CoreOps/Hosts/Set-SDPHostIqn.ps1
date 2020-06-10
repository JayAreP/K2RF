function Set-SDPHostIqn {
    param(
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('pipeName')]
        [string] $hostName,
        [parameter(Mandatory)]
        [string] $iqn,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = 'host_iqns'
    }

    process{
        ## Special Ops

        $hostid = Get-SDPHost -name $hostname
        $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath 'hosts' -ObjectID $hostid.id -nestedObject

        # Build the Object
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "iqn" -Value $iqn
        $o | Add-Member -MemberType NoteProperty -Name "host" -Value $hostPath
        
        $body = $o

        ## Make the call
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
        return $results
    }
    
    
}

