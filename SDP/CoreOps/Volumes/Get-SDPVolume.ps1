function Get-SDPVolume {
    param(
        [parameter()]
        [Alias("CurrentReplicationStats")]
        [string] $current_replication_stats,
        [parameter()]
        [Alias("CurrentStats")]
        [string] $current_stats,
        [parameter()]
        [string] $description,
        [parameter()]
        [int] $ObjectId,
        [parameter()]
        [Alias("IscsiTgtConvertedName")]
        [string] $iscsi_tgt_converted_name,
        [parameter()]
        [Alias("IsDedup")]
        [bool] $is_dedup,
        [parameter()]
        [Alias("IsNew")]
        [bool] $is_new,
        [parameter()]
        [Alias("LastRestoredFrom")]
        [string] $last_restored_from,
        [parameter()]
        [Alias("LastRestoredTime")]
        [string] $last_restored_time,
        [parameter()]
        [Alias("LogicalCapacity")]
        [int] $logical_capacity,
        [parameter()]
        [Alias("MarkedForDeletion")]
        [bool] $marked_for_deletion,
        [parameter()]
        [string] $name,
        [parameter()]
        [Alias("NodeId")]
        [int] $node_id,
        [parameter()]
        [Alias("ReplicationPeerVolume")]
        [string] $replication_peer_volume,
        [parameter()]
        [int] $size,
        [parameter()]
        [Alias("SnapshotsLogicalCapacity")]
        [string] $snapshots_logical_capacity,
        [parameter()]
        [Alias("VmwareSupport")]
        [bool] $vmware_support,
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [Alias("VolumeGroup")]
        [string] $volume_group,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    begin {
        $endpoint = "volumes"
    }

    process {

        # Special Ops

        # Volume Group query

        if ($volume_group) {
            Write-Verbose "volume_group specified, parsing KDP Object"
            $PSBoundParameters.volume_group = ConvertTo-SDPObjectPrefix -ObjectPath volume_groups -ObjectID $volume_group -nestedObject
        }

        # OjectId fix

        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
        }
        # return $PSBoundParameters
        return $results
    }
}
