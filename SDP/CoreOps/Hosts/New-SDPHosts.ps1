function New-SDPHosts {
    param(
        [parameter()]
        [Alias("HostGroup")]
        [string] $host_group,
        [parameter(Mandatory)]
        [string] $name,
        [parameter(Mandatory)]
        [ValidateSet('Linux','Windows','ESX',IgnoreCase = $false)]
        [string] $type,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $plist = Remove-CommonParams -parameterList $PSBoundParameters

    $ignoreArray = @('host_group')    

    $body = New-Object psobject
    foreach ($i in $plist.keys) {
        $par = $i
        $val = $plist[$i]
        if ($ignoreArray -notcontains $par) {
            $body | Add-Member -MemberType NoteProperty -Name $par -Value $val
        }
    }

    # start special ops

    if ($host_group) {
        $opt = ConvertTo-SDPObjectPrefix -ObjectID $host_group -ObjectPath host_groups -nestedObject
        $body | Add-Member -MemberType NoteProperty -Name 'host_group' -Value $opt
    }

    # end special ops

    $endpoint = "hosts"
    
    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
    }
    return $results
}
