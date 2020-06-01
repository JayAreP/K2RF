function Get-SDPHostGroup {
    param(
        [parameter()]
        [int] $id,
        [parameter(position=1)]
        [string] $name,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    
    begin {
        $endpoint = "host_groups"
    }

    process {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
        return $results
    }
}
