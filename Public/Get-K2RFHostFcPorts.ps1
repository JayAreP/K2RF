function Get-K2RFHostFcPorts {
    param(
        [parameter()]
        [Alias("host")]
        [string] $hostref,
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $pwwn,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    $endpoint = "host_fc_ports"

    if ($hostref) {
        $PSBoundParameters.host = $PSBoundParameters.hostref 
        $PSBoundParameters.remove('hostref') | Out-Null
    }

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    $PSBoundParameters
    return $results.hits
}
