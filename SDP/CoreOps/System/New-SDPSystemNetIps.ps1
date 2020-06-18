function New-SDPSystemNetIps {
    param(
        [parameter(Mandatory)]
        [IPAddress] $ipAddress, 
        [parameter(Mandatory)]
        [IPAddress] $subnetMask,
        [parameter(Mandatory)]
        [ValidateSet('iscsi','replication')]
        [string] $service,
        [parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('pipeId')]
        [string] $interface,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = "system/net_ips"
    }

    process{
        ## Special Ops

        $interfacePath = ConvertTo-SDPObjectPrefix -ObjectPath 'system/net_ports' -ObjectID $interface -nestedObject

        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "ip_address" -Value $ipAddress.IPAddressToString
        $o | Add-Member -MemberType NoteProperty -Name "network_mask" -Value $subnetMask.IPAddressToString
        $o | Add-Member -MemberType NoteProperty -Name "service" -Value $service
        $o | Add-Member -MemberType NoteProperty -Name "interface" -Value $interfacePath

        # Make the call 

        $body = $o
        
        try {
            Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context -erroraction silentlycontinue
        } catch {
            return $Error[0]
        }

        $results = Get-SDPSystemNetIps -ip_address $ipAddress.IPAddressToString
        while (!$results) {
            Write-Verbose " --> Waiting on NetIP"
            $results = Get-SDPSystemNetIps -ip_address $ipAddress.IPAddressToString
            Start-Sleep 1
        }

        return $results

    }
}

