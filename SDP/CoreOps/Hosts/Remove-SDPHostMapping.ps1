function Remove-SDPHostMapping {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    <#
        .SYNOPSIS

        .EXAMPLE 
        Remove-SDPHostMapping -id 432
        
        .DESCRIPTION

        .NOTES
        Authored by J.R. Phillips (GitHub: JayAreP)

        .LINK
        https://www.github.com/JayAreP/K2RF/

    #>

    begin {
        $endpoint = 'mappings'
    }

    process {
        ## Make the call
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results
    }
}