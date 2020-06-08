function New-SDPHostGroup {
    param(
        [parameter(mandatory)]
        [string] $name,
        [parameter()]
        [string] $description,
        [parameter()]
        [string] $ConnectivityType,
        [parameter()]
        [switch] $allowDifferentHostTypes,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
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
        $endpoint = "host_groups"
    }

    process{
        ## Special Ops

        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "name" -Value $name
        if ($description) {
            $o | Add-Member -MemberType NoteProperty -Name "description" -Value $description
        }
        if ($ConnectivityType) {
            $o | Add-Member -MemberType NoteProperty -Name "connectivity_type" -Value $ConnectivityType
        }
        if ($allowDifferentHostTypes) {
            $o | Add-Member -MemberType NoteProperty -Name "allow_different_host_types" -Value $true
        }

        $body = $o
        
        ## Make the call
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
        return $results
    }
}
