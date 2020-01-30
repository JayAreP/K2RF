function New-K2RFURI {
    param(
        [parameter(Mandatory)]
        [string] $endpoint,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    <#
        .SYNOPSIS 
        Helper function for auto-generating an appropriate URI string for the Kaminario K2 Powershell SDK.
        
        .EXAMPLE
        New-K2RFURI -endpoint volume_groups
        
        This will return the full URI (https://{k2appliance}/api/v2/volume_groups) for the specified endpoint. 
    #>

    # trim front and rear / marks if needed

    if ($endpoint[0] -eq '/') {
        $endpoint = $endpoint.Substring(1)
    }
    
    if ($endpoint[-1] -eq '/') {
        $endpoint = $endpoint.Substring(0,$endpoint.Length-1)
    }

    $server = Get-Variable -Scope Global -Name $k2context -ValueOnly
    $results = 'https://' + $server.K2Endpoint + '/api/v2/' + $endpoint + '?'
    return $results
}