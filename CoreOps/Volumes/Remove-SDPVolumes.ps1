function Remove-SDPVolumes {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $objectid,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = "volumes"
    }

    process {
        if ($name) {
            $volname = Get-SDPVolumes -name $name
            if (!$volname) {
                return "No volume with name $name exists."
            } elseif (($volname | measure-object).count -gt 1) {
                return "Too many replies with $name"
            } else {
                $objectid = $volname.id
            }
        }
        $endpointURI = $endpoint + '/' + $objectid
        Write-Verbose "Removing volume with id $objectid"
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context -Verbose
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        }
        return $results.hits
    }
}
