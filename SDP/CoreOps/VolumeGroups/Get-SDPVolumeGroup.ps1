function Get-SDPVolumeGroup {
    param(
        [parameter()]
        [Alias("CapacityPolicy")]
        [string] $capacity_policy,
        [parameter()]
        [Alias("CapacityState")]
        [string] $capacity_state,
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
        [string] $name,
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
        [Alias("SnapshotsLogicalCapacity")]
        [string] $snapshots_logical_capacity,
        [parameter()]
        [Alias("SnapshotsOverheadState")]
        [string] $snapshots_overhead_state,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    $endpoint = 'volume_groups'
    
    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
