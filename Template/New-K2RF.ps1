function CMDLETNAME {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops

    ## Build the body
    $plist = Remove-CommonParams -parameterList $PSBoundParameters
    $body = New-ObjectFromHash -inputHash $plist

    ## Make the call
    $endpoint = ENDPOINTNAME
    $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 

    if ($results) {
        $success = Get-CMDLETNAME -name $name
        return $success
    }
}
