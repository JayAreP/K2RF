function Get-K2RFEvents {
    param(
        [parameter()]
        [Alias("EventId")]
        [int] $event_id,
        [parameter()]
        [int] $id,
        [parameter()]
        [string] $labels,
        [parameter()]
        [string] $level,
        [parameter()]
        [string] $message,
        [parameter()]
        [string] $name,
        [parameter()]
        [datetime] $timestamp,
        [parameter()]
        [string] $user,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    <#
        .SYNOPSIS
        Gather the requested event information.

        .EXAMPLE
        Get-K2RFEvents -EventId 28

        This will return all DELETE_VOLUME operations and their corresponding event information. 
    #>

    $endpoint = 'events'

    # function specific operations

    if ($timestamp) {
        $cdate = Convert-K2RFTimeStamp -timestamp $timestamp
        $PSBoundParameters.remove('timestamp') | Out-Null
        $PSBoundParameters.timestamp = $cdate
    }
    
    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-K2RFRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results.hits
}