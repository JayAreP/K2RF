function Get-K2RFHosts {
    param(
        [parameter()]
        [Alias("HostGroup")]
        [string] $host_group,
        [parameter()]
        [int] $id,
        [parameter()]
        [Alias("IsPartOfGroup")]
        [bool] $is_part_of_group,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $type,
        [parameter()]
        [Alias("ViewsCount")]
        [string] $views_count,
        [parameter()]
        [Alias("VolumesCount")]
        [int] $volumes_count,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    
    $endpoint = "hosts"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}