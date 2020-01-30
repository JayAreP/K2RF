function Get-K2RFHostGroups {
    param(
        [parameter()]
        [Alias("AllowDifferentHostTypes")]
        [bool] $allow_different_host_types,
        [parameter()]
        [string] $description,
        [parameter()]
        [Alias("HostsCount")]
        [int] $hosts_count,
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $name,
        [parameter()]
        [Alias("ViewsCount")]
        [int] $views_count,
        [parameter()]
        [Alias("VolumesCount")]
        [int] $volumes_count,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    
    $endpoint = "host_groups"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}