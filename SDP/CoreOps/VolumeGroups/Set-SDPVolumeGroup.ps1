function Set-SDPVolumeGroup {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter(Mandatory)]
        [string] $name,
        [parameter()]
        [int] $quotaInGB,
        [parameter()]
        [switch] $enableDeDuplication,
        [parameter()]
        [string] $Description,
        [parameter()]
        [string] $capacityPolicy,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = "volume_groups"
    }

    process {
        ## Special Ops
        if ($quotaInGB) {
            [string]$size = ($quotaInGB * 1024 * 1024)
        }
        
        if ($capacityPolicy) {
            $cappolstats = Get-SDPVgCapacityPolicies | Where-Object {$_.name -eq $capacityPolicy}
            $cappol = ConvertTo-SDPObjectPrefix -ObjectID $cappolstats.id -ObjectPath vg_capacity_policies -nestedObject
        }


        ## Build the object
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name name -Value $name
        if 
        ($quotaInGB) {
            $o | Add-Member -MemberType NoteProperty -Name quota -Value $size
        } else {
            $o | Add-Member -MemberType NoteProperty -Name quota -Value 0
        }
        
        if ($Description) {
            $o | Add-Member -MemberType NoteProperty -Name description -Value $Description
        }
        if ($capacityPolicy) {
            $o | Add-Member -MemberType NoteProperty -Name capacity_policy -Value $cappol
        }
        if ($enableDeDuplication) {
            $o | Add-Member -MemberType NoteProperty -Name is_dedupe -Value $true
        }

        $body = $o 

        $endpointURI = $endpoint + '/' + $objectid
        
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method PATCH -body $body -k2context $k2context -Verbose 
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method PATCH -body $body -k2context $k2context 
        }
        return $results


    }
}