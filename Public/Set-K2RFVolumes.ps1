function Set-K2RFVolumes {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    $PSBoundParameters.remove('Verbose')
    $PSBoundParameters.remove('k2context')
<#
First option:
name
size
description
volume_group (to move volume between volume groups)
read_only
#>
    $body = $PSBoundParameters

    $endpoint = "volumes"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -parameterList $PSBoundParameters -body $body -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -parameterList $PSBoundParameters -body $body -k2context $k2context -body $body
    }
    return $results.hits
}
