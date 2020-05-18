function ConvertTo-HostGroupPrefix {
    param(
        [parameter(Mandatory)]
        [string] $hostID,
        [switch] $nestedObject
    )

    $hostprefix = '/host_groups/' + $hostID
    if ($nestedObject) {
        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name 'ref' -Value $hostprefix
        return $o
    } else {
        return $hostprefix
    }
}