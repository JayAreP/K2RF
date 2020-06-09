function Get-SDPRetentionPolicy {
    param(
        [parameter()]
        [int] $days,
        [parameter()]
        [string] $hours,
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $name,
        [parameter()]
        [Alias("NumSnapshots")]
        [string] $num_snapshots,
        [parameter()]
        [Alias("SnapshotsUsageCount")]
        [int] $snapshots_usage_count,
        [parameter()]
        [string] $weeks,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "retention_policies"

    $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    return $results
}
