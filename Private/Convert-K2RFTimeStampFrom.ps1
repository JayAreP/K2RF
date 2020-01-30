function Convert-K2RFTimeStampFrom {
    param(
        [parameter(Mandatory)]
        [int] $timestamp
    )

    $epoch = Get-Date -Date "01/01/1970"
    return $epoch.AddSeconds($timestamp)
}