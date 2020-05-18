function Test-ParameterTable {
    param(
        [parameter()]
        [int] $intParam,
        [parameter()]
        [string] $stringParam,
        [parameter()]
        [array] $arrayParam,
        [parameter()]
        [hashtable] $hashParam,
        [parameter()]
        [string] $k2contet = "k2rfconnection"
    )
    return $PSBoundParameters
}