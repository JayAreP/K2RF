function New-URLEncode {
    param(
        [parameter(Mandatory)]
        [string] $URL
    )
    $baseurl = 'https://' + $Global:k2rfconnection.K2Endpoint
    $url = $url.Split($baseurl)[-1].Replace(':','%3A').replace('.','%2E')
    $url = $baseurl + $url
    return $url
}