function test-idfrompipe {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [string] $PipeID
    )

    return $PipeID
}