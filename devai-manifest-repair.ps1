# DevAiCoreX Manifest Repair Script
# Ensures parentPath = module base name only

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

$manifestPath = "$Root\manifest.jsonc"
if (!(Test-Path $manifestPath)) { Write-Host "[FATAL] Manifest not found." -ForegroundColor Red; exit 1 }
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json

Write-Host "`n=== DevAiCoreX Manifest Repair ===`n" -ForegroundColor Cyan

foreach ($entry in $manifest.entries) {

    $name = $entry.name

    # parentPath must always be the module base name
    $entry.parentPath = $name

    Write-Host "Repaired parentPath for module: $name" -ForegroundColor Yellow
}

# Write updated manifest
$manifest | ConvertTo-Json -Depth 20 | Set-Content $manifestPath

Write-Host "`nManifest repair complete. parentPath normalized." -ForegroundColor Cyan
