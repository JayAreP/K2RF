function Get-K2RFVolumes2 {
    param(
        [parameter()]
        [Alias("AvgCompressedRatio")]
        [int] $avg_compressed_ratio,
        [parameter()]
        [Alias("AvgCompressedRatioTimestamp")]
        [string] $avg_compressed_ratio_timestamp,
        [parameter()]
        [Alias("CreationTime")]
        [int] $creation_time,
        [parameter()]
        [Alias("CurrentReplicationStats")]
        [string] $current_replication_stats,
        [parameter()]
        [Alias("CurrentStats")]
        [string] $current_stats,
        [parameter()]
        [Alias("DedupSource")]
        [int] $dedup_source,
        [parameter()]
        [Alias("DedupTarget")]
        [int] $dedup_target,
        [parameter()]
        [string] $description,
        [parameter()]
        [int] $id,
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
        [Alias("NoDedup")]
        [int] $no_dedup,
        [parameter()]
        [Alias("ReplicationPeerVolume")]
        [string] $replication_peer_volume,
        [parameter()]
        [Alias("ScsiSn")]
        [string] $scsi_sn,
        [parameter()]
        [Alias("ScsiSuffix")]
        [int] $scsi_suffix,
        [parameter()]
        [int] $size,
        [parameter()]
        [Alias("SnapshotsLogicalCapacity")]
        [string] $snapshots_logical_capacity,
        [parameter()]
        [Alias("StreamAvgCompressedSizeInBytes")]
        [string] $stream_avg_compressed_size_in_bytes,
        [parameter()]
        [Alias("VmwareSupport")]
        [bool] $vmware_support,
        [parameter()]
        [Alias("VolumeGroup")]
        [string] $volume_group,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "volumes"

    $body = @{}

    foreach ($param in $PSBoundParameters.GetEnumerator()) {

        if ([System.Management.Automation.PSCmdlet]::CommonParameters -contains $param.key) {
            continue
        }

        $body.add($param.Key, $param.Value)
    }

    $results = (Invoke-K2RFRestCall -endpoint $endpoint -method GET -k2context $k2context).hits
    
    $searchkeys = $body.keys.split()

    foreach ($i in $searchkeys) {
        $results = $results | where-object {$_.$i -eq $body[$i]} 
    }
    return $results
}

