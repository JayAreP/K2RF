function Get-SDPStaticRoutes {
    param(
        [parameter()]
        [Alias("DestinationSubnetIp")]
        [string] $destination_subnet_ip,
        [parameter()]
        [Alias("DestinationSubnetMask")]
        [string] $destination_subnet_mask,
        [parameter()]
        [Alias("GatewayIp")]
        [string] $gateway_ip,
        [parameter()]
        [Alias("ContainedIn")]
        [int] $id,
        [parameter()]
        [Alias("ContainedIn")]
        [string] $knode,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "static_routes"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
