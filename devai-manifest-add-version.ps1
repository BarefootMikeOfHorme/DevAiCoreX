# DevAiCoreX Manifest Add-Version Script
# Adds missing version fields to all manifest entries

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

$manifestPath = "$Root\manifest.jsonc"
if (!(Test-Path $manifestPath)) { Write-Host "[FATAL] Manifest not found." -ForegroundColor Red; exit 1 }
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

$globalVersion = $manifest.version
Write-Host "`n=== DevAiCoreX Manifest Add-Version ===`n" -ForegroundColor Cyan

foreach ($entry in $manifest.entries) {
    if (-not $entry.PSObject.Properties.Name -contains "version") {
        $entry | Add-Member -NotePropertyName version -NotePropertyValue $globalVersion -Force
        Write-Host "Added version field to module: $($entry.name)" -ForegroundColor Yellow
    }
}

$manifest | ConvertTo-Json -Depth 20 | Set-Content $manifestPath

Write-Host "`nManifest version-field repair complete." -ForegroundColor Cyan
