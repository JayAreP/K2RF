function New-SDPHostMapping {
    param(
        [parameter(ValueFromPipelineByPropertyName,Mandatory)]
        [Alias('name')]
        [string] $hostName,
        [parameter()]
        [string] $volumeName,
        [parameter()]
        [string] $hostGroupName,
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
        $endpoint = 'mappings'
    }

    process{
        ## Special Ops
        $hostid = Get-SDPHost -name $hostName
        $volumeid = Get-SDPVolume -name $volumeName
        $hostGroupid = Get-SDPHostGroup -name $hostGroupName

        if ($hostName) {
            $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "hosts" -ObjectID $hostid.id -nestedObject
        } elseif ($hostGroupName) {
            $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "hosts" -ObjectID $hostGroupid.id -nestedObject
        }
        $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "volumes" -ObjectID $volumeid.id -nestedObject

        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "host" -Value $hostPath
        $o | Add-Member -MemberType NoteProperty -Name "volume" -Value $volumePath

        $body = $o

        ## Make the call
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
        return $results
    }
}