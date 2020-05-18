  #Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$CoreOps = @( Get-ChildItem -Path $PSScriptRoot\CoreOps\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
<#
$Public  = @( Get-ChildItem -Path .\Public\*.ps1 -ErrorAction SilentlyContinue )
$CoreOps = @( Get-ChildItem -Path .\CoreOps\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path .\\Private\*.ps1 -ErrorAction SilentlyContinue )
$allpublic = @($Public + $CoreOps)
Foreach($import in @($Public + $Private + $CoreOps)) {
    $import.fullname
}
#>
$allpublic = @($Public + $CoreOps)
#Dot source the files
Foreach($import in @($allpublic + $Private))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Export the Public modules
Export-ModuleMember -Function $allpublic.Basename -verbose