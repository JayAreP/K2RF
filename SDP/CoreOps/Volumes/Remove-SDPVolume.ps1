function Remove-SDPVolume {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $objectid,
        [parameter()]
        [string] $name,
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
        $endpoint = "volumes"
    }

    process {

        # Special Ops

        if ($name) {
            $volname = Get-SDPVolume -name $name
            if (!$volname) {
                return "No volume with name $name exists."
            } elseif (($volname | measure-object).count -gt 1) {
                return "Too many replies with $name"
            } else {
                $objectid = $volname.id
            }
        }

        # Call
        
        $endpointURI = $endpoint + '/' + $objectid
        Write-Verbose "Removing volume with id $objectid"
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context

        return $results
    }
}
