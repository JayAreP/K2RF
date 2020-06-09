function Remove-SDPRetentionPolicy {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops
    begin {
        $endpoint = "retention_policies"
    }

    process {
        ## Make the call
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results
    }
}