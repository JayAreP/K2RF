function Get-SDPEventsTargetFilters {
    param(
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $label,
        [parameter()]
        [string] $level,
        [parameter()]
        [Alias("TargetId")]
        [int] $target_id,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )
    $endpoint = "events/target_filters"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
