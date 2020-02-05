function New-K2RFHosts {
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

    $PSBoundParameters.remove('Verbose')
    $PSBoundParameters.remove('k2context')

    $ignoreArray = @('host_group')    

    $body = New-Object psobject
    foreach ($i in $PSBoundParameters.keys) {
        $par = $i
        $val = $PSBoundParameters[$i]
        if ($ignoreArray -notcontains $par) {
            $body | Add-Member -MemberType NoteProperty -Name $par -Value $val
        }
    }

    # start special ops

    if ($host_group) {
        $opt = ConvertTo-HostGroupPrefix -hostID $host_group -nestedObject
        $body | Add-Member -MemberType NoteProperty -Name 'host_group' -Value $opt
    }

    # end special ops

    $endpoint = "hosts"
    
    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
    }
    return $results
}
