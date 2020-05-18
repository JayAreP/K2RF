function New-SDPHostIqns {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $PSBoundParameters.remove('Verbose')
        $PSBoundParameters.remove('k2context')
        $body = $PSBoundParameters

        $endpoint = "host_iqns"
    }

    process {
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -parameterList $PSBoundParameters -body $body -Verbose -k2context $k2context
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -parameterList $PSBoundParameters -body $body -k2context $k2context
        }
        return $results
    }
}
