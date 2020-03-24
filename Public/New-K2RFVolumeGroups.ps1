function New-K2RFVolumeGroups {
    param(
        [parameter(Mandatory)]
        [string] $name,
        [parameter()]
        [int] $quota,
        [parameter()]
        [switch] $enableDeDuplication,
        [parameter()]
        [switch] $Description,
        [parameter()]
        [string] $capacityPolicy,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    
    ## Special Ops
    if ($quota) {
        [string]$size = ($quota * 1024 * 1024)
    }
    
    if ($capacityPolicy) {
        $cappolstats = Get-K2RFVgCapacityPolicies | Where-Object {$_.name -eq $capacityPolicy}
        $cappol = ConvertTo-K2RFObjectPrefix -ObjectID $cappolstats.id -ObjectPath vg_capacity_policies -nestedObject
    }


    ## Build the object
    $o = New-Object psobject
    $o | Add-Member -MemberType NoteProperty -Name name -Value $name
    if ($quota) {
        $o | Add-Member -MemberType NoteProperty -Name quota -Value $size
    } else {
        $o | Add-Member -MemberType NoteProperty -Name quota -Value 0
    }
    
    if ($Description) {
        $o | Add-Member -MemberType NoteProperty -Name description -Value $Description
    }
    if ($capacityPolicy) {
        $o | Add-Member -MemberType NoteProperty -Name capacity_policy -Value $cappol
    }
    if ($enableDeDuplication) {
        $o | Add-Member -MemberType NoteProperty -Name is_dedupe -Value $true
    }
    
    $body = $o

    $endpoint = "volume_groups"

    $results = Invoke-K2RFRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context

    if ($results) {
        $success = Get-K2RFVolumeGroups -name $name
        return $success
    }
}
