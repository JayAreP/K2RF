function Set-SDPHost {
    param(
        [parameter(ValueFromPipelineByPropertyName,Mandatory)]
        [Alias('id')]
        [string] $objectid,
        [parameter()]
        [Alias("HostGroup")]
        [string] $host_group,
        [parameter()]
        [string] $name,
        [parameter()]
        [ValidateSet('Linux','Windows','ESX',IgnoreCase = $false)]
        [string] $type,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    begin {
        $endpoint = "hosts"
    }

    process {        
        $o = New-Object psobject
        if ($name) {
            $o | Add-Member -MemberType NoteProperty -Name 'name' -Value $name
        }
        if ($type) {
            $o | Add-Member -MemberType NoteProperty -Name 'type' -Value $type
        }
        if ($host_group) {
            $opt = ConvertTo-SDPObjectPrefix -ObjectID $host_group -ObjectPath host_groups -nestedObject
            $o | Add-Member -MemberType NoteProperty -Name 'host_group' -Value $opt
        }

        $body = $o 

        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method PATCH -body $body -k2context $k2context 
        return $results
    }
}