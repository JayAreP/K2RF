function Remove-SDPHost {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $objectid,
        [parameter(Position=1)]
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
        $endpoint = "hosts"
    }

    process {
        if ($name) {
            $objectid = (Get-SDPHost -name $name).id
        }
        Write-Verbose "Removing volume with id $objectid"
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results.hits
    }
}

