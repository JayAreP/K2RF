function Get-SDPHostMapping {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('name')]
        [string] $hostName,
        [parameter()]
        [int] $id,
        [parameter()]
        [int] $lun,
        [parameter()]
        [Alias("UniqueTarget")]
        [bool] $unique_target,
        [parameter()]
        [string] $volumeName,
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
        $endpoint = "mappings"
    }
    
    process {
        # parameter cleanup
        <#
        if ($hostName) {
            $PSBoundParameters.host = $PSBoundParameters.hostref 
            $PSBoundParameters.remove('hostref') | Out-Null
        }
        #>

        # special ops
        if ($hostName) {
            $hostObj = Get-SDPHost -name $hostName
            $hostPath = ConvertTo-SDPObjectPrefix -ObjectPath "hosts" -ObjectID $hostObj.id -nestedObject
            $PSBoundParameters.host = $hostPath 
            $PSBoundParameters.remove('hostName') | Out-Null
        }

        if ($volumeName) {
            $volumeObj = Get-SDPVolume -name $volumeName
            $volumePath = ConvertTo-SDPObjectPrefix -ObjectPath "volumes" -ObjectID $volumeObj.id -nestedObject
            $PSBoundParameters.volume = $volumePath 
            $PSBoundParameters.remove('volumeName') | Out-Null
        }
        # make the call
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
        return $results
    }

}
