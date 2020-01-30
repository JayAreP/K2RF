function Invoke-K2RFRestCall{
    param(
        [parameter(Mandatory)]
        [string] $endpoint,
        [parameter(Mandatory)]
        [ValidateSet('GET','POST','PATCH','DELETE')]
        [string] $method,
        [parameter()]
        [string] $body,
        [parameter()]
        [hashtable] $parameterList,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    <#
        .SYNOPSIS 
        Custom rest call for Kaminario K2 platform 

        .EXAMPLE
        (after logging into a K2)
        Invoke-K2RFRestCall -endpoint volume_groups -method GET
        This will return the .hits return for the https://{k2Server}/api/v2/volume_groups API endpoint using the method GET.

        .EXAMPLE
        Invoke-K2RFRestCall -endpoint volume -method PATCH -body $body -k2context TestDev
        This will render the .hits return for the https://{k2Server}/api/v2/volumes API endpoint. 
    #>

    # Delcare the serviced API endpoint.

    $endpointURI = New-K2RFURI -endpoint $endpoint -k2context $k2context

    # Cleanup the paramter list and construct the URI with the argued parameters. 

    if ($parameterList) {
        $parameterList.Remove('Verbose')
        $parameterList.Remove('k2context')
        foreach ($i in $parameterList.keys) {
            $par = $i
            $val = $parameterList[$i]
            Write-Verbose "Passing PARAMETER - $par - as VALUE -- $val --"
            if ([string]($val -as [int])) {
                $endpointURI = $endpointURI + $par + '__in=' + $val + '&'
            } else {
                $endpointURI = $endpointURI + $par + '__contains=' + $val + '&'
            }
        }
    }

    # Clean up the final URI.

    $endpointURI = $endpointURI.Substring(0,$endpointURI.Length-1)
    $endpointURI = New-URLEncode -URL $endpointURI

    Write-Verbose "Requesting GET from $endpointURI"
    if ($body) {
        $bodyjson = $body | ConvertTo-Json -Depth 10
        Write-Verbose "using the following body:" `n$bodyjson
    }

    # decalre the requested context's credential information 

    $restContext = Get-Variable -Scope Global -Name $k2context -ValueOnly

    # Make the call. 

    if ($body) {
        $results = Invoke-RestMethod -Method $method -Uri $endpointURI -Body $body -Credential $restContext.credentials -SkipCertificateCheck
    } else {
        $results = Invoke-RestMethod -Method $method -Uri $endpointURI -Credential $restContext.credentials -SkipCertificateCheck
    }

    # Return the results of the call back to the cmdlet.
    
    return $results
}