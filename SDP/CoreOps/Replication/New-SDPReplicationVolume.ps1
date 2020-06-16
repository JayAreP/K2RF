function New-SDPReplicationVolume {
    param(
        [parameter(ValueFromPipelineByPropertyName, Mandatory)]
        [Alias('pipeName')]
        [string] $name,
        [parameter(Mandatory)]
        [string] $volumeName,
        [parameter(Mandatory)]
        [string] $replicationSession,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = 'replication/peer_volumes'
    }

    process{
        ## Special Ops

        $volumeId = Get-SDPVolume -name $volumeName
        $sessionId = Get-SDPReplicationPeerArray -name $replicationSession

        $volumeId = Get-SDPVolumeGroup -name $volumeGroupName
        $volumeGroupPath = ConvertTo-SDPObjectPrefix -ObjectID $volumeId.id -ObjectPath 'volume_groups' -nestedObject

        $sessionId = Get-SDPReplicationPeerArray -name $replicationSession
        $peerArrayPath = ConvertTo-SDPObjectPrefix -ObjectID $sessionId.id -ObjectPath 'replication/sessions' -nestedObject

        # Build the object
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "name" -Value $name
        $o | Add-Member -MemberType NoteProperty -Name "local_volume" -Value $volumeGroupPath
        $o | Add-Member -MemberType NoteProperty -Name "replication_session" -Value $peerArrayPath

        # Make the call 

        $body = $o
        
        try {
            # Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context -erroraction silentlycontinue
        } catch {
            return $Error[0]
        }
        
        return $body
    }
}

