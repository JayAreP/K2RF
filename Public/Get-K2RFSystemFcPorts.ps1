function Get-K2RFSystemFcPorts {
    param(
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $pwwn,
        [parameter()]
        [string] $server,
        [parameter()]
        [Alias("SpeedState")]
        [string] $speed_state,
        [parameter()]
        [string] $status,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "system/fc_ports"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
