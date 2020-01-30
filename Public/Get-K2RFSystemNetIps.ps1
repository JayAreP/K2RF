function Get-K2RFSystemNetIps {
    param(
        [parameter()]
        [int] $id,
        [parameter()]
        [Alias("IpAddress")]
        [string] $ip_address,
        [parameter()]
        [Alias("NetworkMask")]
        [string] $network_mask,
        [parameter()]
        [Alias("NetPort")]
        [string] $net_port,
        [parameter()]
        [Alias("NetPortchannel")]
        [string] $net_portchannel,
        [parameter()]
        [Alias("NetVlan")]
        [string] $net_vlan,
        [parameter()]
        [Alias("WanPort")]
        [string] $wan_port,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )
    $endpoint = "system/net_ips"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
