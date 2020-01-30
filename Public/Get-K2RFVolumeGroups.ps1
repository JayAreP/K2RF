function Get-K2RFVolumeGroups {
    param(
        [parameter()]
        [Alias("CapacityPolicy")]
        [string] $capacity_policy,
        [parameter()]
        [Alias("CapacityState")]
        [string] $capacity_state,
        [parameter()]
        [Alias("CreationTime")]
        [int] $creation_time,
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
        [Alias("IsDefault")]
        [bool] $is_default,
        [parameter()]
        [Alias("LastRestoredFrom")]
        [string] $last_restored_from,
        [parameter()]
        [Alias("LastRestoredTime")]
        [string] $last_restored_time,
        [parameter()]
        [Alias("LastSnapshotCreationTime")]
        [string] $last_snapshot_creation_time,
        [parameter()]
        [Alias("LogicalCapacity")]
        [int] $logical_capacity,
        [parameter()]
        [Alias("MappedHostsCount")]
        [string] $mapped_hosts_count,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $quota,
        [parameter()]
        [Alias("ReplicationPeerVolumeGroup")]
        [string] $replication_peer_volume_group,
        [parameter()]
        [Alias("ReplicationRpoHistory")]
        [string] $replication_rpo_history,
        [parameter()]
        [Alias("ReplicationSession")]
        [string] $replication_session,
        [parameter()]
        [Alias("SnapshotsCount")]
        [string] $snapshots_count,
        [parameter()]
        [Alias("SnapshotsLogicalCapacity")]
        [string] $snapshots_logical_capacity,
        [parameter()]
        [Alias("SnapshotsOverheadState")]
        [string] $snapshots_overhead_state,
        [parameter()]
        [Alias("ViewsCount")]
        [string] $views_count,
        [parameter()]
        [Alias("VolumesCount")]
        [int] $volumes_count,
        [parameter()]
        [Alias("VolumesLogicalCapacity")]
        [int] $volumes_logical_capacity,
        [parameter()]
        [Alias("VolumesProvisionedCapacity")]
        [string] $volumes_provisioned_capacity,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    $endpoint = 'volume_groups'
    
    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}