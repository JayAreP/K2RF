function Get-K2RFSystemFcConnectionMapper {
    param(
        [parameter()]
        [Alias("HostFcPort")]
        [string] $host_fc_port,
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $server,
        [parameter()]
        [Alias("ServerFcPort")]
        [string] $server_fc_port,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "system/fc_connection_mapper"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
