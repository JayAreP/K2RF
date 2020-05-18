function Get-SDPHostFcPorts {
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
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
