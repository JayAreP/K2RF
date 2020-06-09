function CMDLETNAME {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = ENDPOINTNAME
    }

    process{
        ## Special Ops

        $o = New-Object psobject
        if ($name) {
            $o | Add-Member -MemberType NoteProperty -Name "name" -Value $name
        }
        if ($size) {
            $o | Add-Member -MemberType NoteProperty -Name "size" -Value $size
        }

        $body = $o

        ## Make the call
        $results = Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context 
        return $results
    }
    
    
}
