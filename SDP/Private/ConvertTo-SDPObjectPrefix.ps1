function ConvertTo-SDPObjectPrefix {
    param(
        [parameter(Mandatory)]
        [string] $ObjectID,
        [parameter(Mandatory)]
        [ValidateSet('volumes','volume_groups','hosts','host_groups','snapshots','vg_capacity_policies',IgnoreCase = $false)]
        [string] $ObjectPath,
        [parameter()]
        [switch] $nestedObject,
        [parameter()]
        [switch] $compact
    )


    $hostprefix = '/' + $ObjectPath + '/' + $ObjectID
    if ($nestedObject) {
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name 'ref' -Value $hostprefix
        return $o
    } elseif ($compact) {
        $hostprefix = '@{ref=/' + $ObjectPath + '/' + $ObjectID + '}'
        return $hostprefix
    } else {
        return $hostprefix
    }
}
