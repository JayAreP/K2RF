function Remove-K2RFVolumeGroups {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops
    begin {
        Write-Verbose "Removing..."
    }

    process {
        ## Make the call
        $endpoint = "volume_groups"
        $endpointURI = $endpoint + '/' + $objectid
        # return $endpointURI
        $results = Invoke-K2RFRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results
    }
}