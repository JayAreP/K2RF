function Get-K2RFEventsTargetFilters {
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
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
