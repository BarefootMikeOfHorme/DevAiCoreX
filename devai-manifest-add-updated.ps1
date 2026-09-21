# DevAiCoreX Manifest Add-Updated Script
# Adds missing updated fields to all manifest entries

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

$manifestPath = "$Root\manifest.jsonc"
if (!(Test-Path $manifestPath)) { Write-Host "[FATAL] Manifest not found." -ForegroundColor Red; exit 1 }
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

Write-Host "`n=== DevAiCoreX Manifest Add-Updated ===`n" -ForegroundColor Cyan

foreach ($entry in $manifest.entries) {
    if (-not $entry.PSObject.Properties.Name -contains "updated") {
        $entry | Add-Member -NotePropertyName updated -NotePropertyValue (Get-Date).ToString("o") -Force
        Write-Host "Added updated field to module: $($entry.name)" -ForegroundColor Yellow
    }
}

$manifest | ConvertTo-Json -Depth 20 | Set-Content $manifestPath

Write-Host "`nManifest updated-field repair complete." -ForegroundColor Cyan
