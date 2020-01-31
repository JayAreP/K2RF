function Get-K2RFSystemExpansion {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    $endpoint = "system/expansion"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}
