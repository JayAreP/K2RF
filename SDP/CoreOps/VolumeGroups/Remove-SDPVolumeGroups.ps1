function Remove-SDPVolumeGroups {
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
        $endpoint = "volume_groups"
    }

    process {
        if ($name) {
            $volgrpname = Get-SDPVolumeGroups -name $name
            if (!$volgrpname) {
                return "No volume with name $name exists."
            } elseif (($volgrpname | measure).count -gt 1) {
                return "Too many replies with $name"
            } else {
                $objectid = $volgrpname.id
            }
        }
        Write-Verbose "Removing... $objectid"
        ## Make the call
        $endpointURI = $endpoint + '/' + $objectid
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context -verbose
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        }
        return $results
    }
}
