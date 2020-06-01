function Remove-SDPHost {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $objectid,
        [parameter(Position=1)]
        [string] $name,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = "hosts"
    }

    process {
        if ($name) {
            $objectid = (Get-SDPHost -name $name).id
        }
        Write-Verbose "Removing volume with id $objectid"
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results.hits
    }
}

