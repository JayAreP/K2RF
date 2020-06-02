function Get-SDPVolume {
    param(
        [parameter()]
        [string] $description,
        [parameter()]
        [int] $ObjectId,
        [parameter(Position=1)]
        [string] $name,
        [parameter()]
        [Alias("VmwareSupport")]
        [bool] $vmware_support,
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [Alias("VolumeGroup")]
        [string] $volume_group,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    begin {
        $endpoint = "volumes"
    }

    process {

        # Special Ops

        if ($volume_group) {
            Write-Verbose "volume_group specified, parsing KDP Object"
            $PSBoundParameters.volume_group = ConvertTo-SDPObjectPrefix -ObjectPath volume_groups -ObjectID $volume_group -nestedObject
        }

        # Query 

        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context

        return $results
    }
}
