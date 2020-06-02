function New-SDPHost {
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
    <#
        .SYNOPSIS

        .EXAMPLE 

        .DESCRIPTION

        .NOTES
        Authored by J.R. Phillips (GitHub: JayAreP)

        .LINK
        https://www.github.com/JayAreP/K2RF/

    #>
    begin {
        $endpoint = "hosts"
    }

    process {
    
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name 'name' -Value $name
        $o | Add-Member -MemberType NoteProperty -Name 'type' -Value $type
        if ($host_group) {
            $opt = ConvertTo-SDPObjectPrefix -ObjectID $host_group -ObjectPath host_groups -nestedObject
            $o | Add-Member -MemberType NoteProperty -Name 'host_group' -Value $opt
        }
        # end special ops

        $body = $o
        
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -Verbose -k2context $k2context
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
        }
        return $results
    }

}
