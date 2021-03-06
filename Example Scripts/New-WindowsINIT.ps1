param(
    [parameter(Mandatory)]
    [string] $Data1Interface,
    [parameter()]
    [string] $Data2Interface,
    [parameter()]
    [switch] $startiSCSI,
    [parameter()]
    [int] $sessionsPerPath = 1,
    [parameter()]
    [switch] $addHW,
    [parameter()]
    [switch] $addHost
)
<#
    .SYNOPSIS
        This Script will automatically create and fullfill the iSCSI connection on any windows host by automatically querying the SDP data interfaces.
        You can argue for operations like:
            -addHost -- This will add the host object to the SDP with the local iqn.
            -addHW -- For the first time you run the script, this will add the Silk hardware vendor values to the HW list. 
            -startiSCSI -- This will start the iSCSI service and set it for automatic start. 

    .EXAMPLE
        New-WIndowsINIT.ps1 -Data1Interface 'Ethernet 4' -Data2Interface 'Ethernet 5' -addHost -startiSCSI -addHW 

#>

if ($startiSCSI) {
    Set-Service -Name MSiSCSI -StartupType Automatic
    Start-Service MSiSCSI 
}

if ($addHW) {
    New-MSDSMSupportedHW -VendorID KMNRIO -Product KDP
}

if ($addHost) {
    $INITPort = Get-InitiatorPort
    New-SDPHost -name $env:computername -type Windows
    Set-SDPHostIqn -hostName $env:computername -iqn $INITPort.NodeAddress
}

$iSCSIData1 = Get-NetIPAddress -InterfaceAlias $Data1Interface -AddressFamily ipv4
if ($Data2Interface) {
    $iSCSIData2 = Get-NetIPAddress -InterfaceAlias $Data2Interface -AddressFamily ipv4
}

# Set the global MPIO policy to round robin
Set-MSDSMGlobalDefaultLoadBalancePolicy -Policy LQD
Enable-MSDSMAutomaticClaim -BusType iSCSI -Confirm:$false
Set-MPIOSetting -NewPathVerificationState Enabled
Set-MPIOSetting -NewPathVerificationPeriod 1
Set-MPIOSetting -NewDiskTimeout 60
Set-MPIOSetting -NewRetryCount 3
Set-MPIOSetting -NewPDORemovePeriod 80

$dataPorts = Get-SDPSystemNetPorts | where-object {$_.name -match "data"}

foreach ($i in $dataPorts) {
    $portpath = '/system/net_ports/' + $i.id
    $currentInt = Get-SDPSystemNetIps | Where-Object {$_.net_port.ref -eq $portpath}
    $session = 0
    while ($session -lt $sessionsPerPath) {
        if ($i.name -like "*01") {
            New-IscsiTargetPortal -TargetPortalAddress $currentInt.ip_address -TargetPortalPortNumber 3260 -InitiatorPortalAddress $iSCSIData1.IPAddress
            $SDPIQN = Get-IscsiTarget
            Connect-IscsiTarget -NodeAddress $SDPIQN.NodeAddress -TargetPortalAddress $currentInt.ip_address -TargetPortalPortNumber 3260 -InitiatorPortalAddress $iSCSIData1.IPAddress -IsPersistent $true -IsMultipathEnabled $true
        } elseif ($i.name -like "*02") {
            if ($Data2Interface) {
                New-IscsiTargetPortal -TargetPortalAddress $currentInt.ip_address -TargetPortalPortNumber 3260 -InitiatorPortalAddress $iSCSIData2.IPAddress
                $SDPIQN = Get-IscsiTarget
                Connect-IscsiTarget -NodeAddress $SDPIQN.NodeAddress -TargetPortalAddress $currentInt.ip_address -TargetPortalPortNumber 3260 -InitiatorPortalAddress $iSCSIData2.IPAddress -IsPersistent $true -IsMultipathEnabled $true
            }
        }
    $session++
    }
}

