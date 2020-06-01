function Remove-SDPHostGroup {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops
    begin {
        $endpoint = 'host_groups'
    }

    process {
        if ($name -and !$objectID) {
            $objectid = (Get-SDPHostGroup -name $name).id
        }
        ## Make the call
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results
    }
}