# Example Script for automated deployment of volumes using the SDP module. 

param(
    [parameter(mandatory)]
    [string] $name,
    [parameter(mandatory)]
    [int] $sizeInGB,
    [parameter(mandatory)]
    [int] $numberOfVolumes,
    [parameter()]
    [string] $iqn,
    [parameter()]
    [string] $pwwn
)

<#
    .EXAMPLE
    New-WindowsHostPrep.ps1 -name WindowsHost01 -sizeInGB 30 -numberOfVolumes 3 -pwwn 00:11:22:33:44:55:66:77

    This creates:
        - A Host Object named WindowsHost01 and assigns it the PWWN 00:11:22:33:44:55:66:77
        - A Volume Group named WindowsHost01-vg
        - 3 30GB volumes named WindowsHost01-vol-1 2 and 3 and adds them to the WindowsHost01-vg volume group
        - A mapping of each volume to the WindowsHost01 host object
#>

# Create the host
New-SDPHost -name $name -type Windows

# Create the volume group
$vgname = $name + '-vg'
New-SDPVolumeGroup -name $vgname

# Create the volumes
$number = 1
while ($number -le $numberOfVolumes) {
    $volname = $name + '-vol-' + $number
    New-SDPVolume -VolumeGroupName $vgname -sizeInGB $sizeInGB -name $volname
    New-SDPHostMapping -volumeName $volname -hostName $name
    $number++
}

# Add host connection information
if ($iqn) {Set-SDPHostIqn -iqn $iqn -hostName $name}
if ($pwwn) {Set-SDPHostPwwn -pwwn $pwwn -hostName $name}

Write-Host -ForegroundColor yellow '--- To remove all objects ---'
Write-Host -ForegroundColor yellow "Get-SDPHost -name $name | Get-SDPHostMapping | Remove-SDPHostMapping"
Write-Host -ForegroundColor yellow "Get-SDPHost -name $name | Remove-SDPHost"
Write-Host -ForegroundColor yellow "Get-SDPVolumeGroup -name $vgname | Get-SDPVolume | Remove-SDPVolume"
Write-Host -ForegroundColor yellow "Get-SDPVolumeGroup -name $vgname | Remove-SDPVolumeGroup"