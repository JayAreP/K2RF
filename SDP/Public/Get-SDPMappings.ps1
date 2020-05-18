function Get-SDPMappings {
    param(
        [parameter()]
        [alias("host")]
        [string] $hostref,
        [parameter()]
        [int] $id,
        [parameter()]
        [int] $lun,
        [parameter()]
        [Alias("UniqueTarget")]
        [bool] $unique_target,
        [parameter()]
        [string] $volume,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    $endpoint = "mappings"

    if ($hostref) {
        $PSBoundParameters.host = $PSBoundParameters.hostref 
        $PSBoundParameters.remove('hostref') | Out-Null
    }

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
