function Remove-K2RFVolumes {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $objectid,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        Write-Verbose "Removing volume with id $objectid"
    }

    process {
        $endpoint = "volumes"
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-K2RFRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results.hits
    }
}
