function New-K2RFVolumes {
    param(
        [parameter(Mandatory)]
        [string] $name,
        [parameter(Mandatory)]
        [int] $sizeInGB,
        [parameter(Mandatory)]
        [string] $VolumeGroupName,
        [parameter()]
        [switch] $VMWare,
        [parameter()]
        [string] $Description,
        [parameter()]
        [switch] $ReadOnly,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops
    $vgstats = Get-K2RFVolumeGroups -name $VolumeGroupName
    if (!$vgstats) {
        Return "No volumegroup named $VolumeGroupName exists."
    }
    $vgpath = ConvertTo-K2RFObjectPrefix -ObjectPath volume_groups -ObjectID $vgstats.id -nestedObject
    [string]$size = ($sizeInGB * 1024 * 1024)

    ## Build the object
    $o = New-Object psobject
    $o | Add-Member -MemberType NoteProperty -Name name -Value $name
    $o | Add-Member -MemberType NoteProperty -Name size -Value $size
    $o | Add-Member -MemberType NoteProperty -Name volume_group -Value $vgpath
    if ($VMWare) {
        $o | Add-Member -MemberType NoteProperty -Name vmware_support -Value $true
    }
    if ($Description) {
        $o | Add-Member -MemberType NoteProperty -Name description -Value $Description
    }
    if ($ReadOnly) {
        $o | Add-Member -MemberType NoteProperty -Name read_only -Value $true
    }
    
    $body = $o

    $endpoint = "volumes"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context
    }
        # return $results.hits
        if ($results) {
            $success = Get-K2RFVolumes -name $name
            return $success
        }
}
