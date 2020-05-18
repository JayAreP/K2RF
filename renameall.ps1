param(
    [string] $inputScript
)

$content = Get-Content $inputScript

if ($content -match '-KDP') {
    $updated = $content.replace('-KDP','-SDP')
} else {
    Write-Host "No changes needed for " $inputScript -ForegroundColor yellow
}

if ($updated) {
    $updated | Out-File $inputScript.replace('-KDP','-SDP')
    Remove-Item $inputScript
}


