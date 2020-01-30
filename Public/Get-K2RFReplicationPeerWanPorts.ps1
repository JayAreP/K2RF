function Get-K2RFReplicationPeerWanPorts {
    param(
        [parameter()]
        [Alias("ContainedIn")]
        [int] $id,
        [parameter()]
        [Alias("RemoteWanPortIpAddress")]
        [string] $remote_wan_port_ip_address,
        [parameter()]
        [Alias("RemoteWanPortName")]
        [string] $remote_wan_port_name,
        [parameter()]
        [Alias("ReplicationPeerK2array")]
        [string] $replication_peer_k2array,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "replication/peer_wan_ports"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
