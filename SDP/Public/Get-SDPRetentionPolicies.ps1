function Get-SDPRetentionPolicies {
    param(
        [parameter()]
        [Alias("ContainedIn")]
        [int] $days,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $hours,
        [parameter()]
        [Alias("ContainedIn")]
        [int] $id,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $name,
        [parameter()]
        [Alias("NumSnapshots")]
        [string] $num_snapshots,
        [parameter()]
        [Alias("SnapshotsUsageCount")]
        [int] $snapshots_usage_count,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $weeks,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "retention_policies"

    $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    return $results
}
