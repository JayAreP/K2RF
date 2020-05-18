function New-URLEncode {
    param(
        [parameter(Mandatory)]
        [string] $URL
    )
    $baseurl = 'https://' + $Global:k2rfconnection.K2Endpoint
    $url = $url.Replace($baseurl,$null)
    $url = $url.Replace(':','%3A').replace('.','%2E')
    $url = $baseurl + $url
    return $url
}