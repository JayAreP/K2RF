function Remove-CommonParams {
    param(
        [parameter(Mandatory)]
        [array] $PSBP
    )
    $body = @{}

    foreach ($param in $PSBP) {

        # Skip any common parameters (Debug, Verbose, etc)
        if ([System.Management.Automation.PSCmdlet]::CommonParameters -contains $param.key) {
            continue
        }

        $body.add($param.Key, $param.Value)
    }
    return $body
}