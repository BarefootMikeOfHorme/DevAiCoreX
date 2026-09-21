# DevAiCoreX Engine Inspector
# Shows detailed information about each engine folder.

Write-Host "Inspecting DevAiCoreX engines..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\engines"

if (-not (Test-Path $root)) {
    Write-Host "Engine directory missing." -ForegroundColor Red
    return
}

$engines = Get-ChildItem $root -Directory

foreach ($e in $engines) {
    Write-Host "`nEngine: $($e.Name)" -ForegroundColor Yellow
    $bootstrap = Join-Path $e.FullName "bootstrap.ps1"
    if (Test-Path $bootstrap) {
        Write-Host " - bootstrap.ps1 found" -ForegroundColor Green
    } else {
        Write-Host " - bootstrap.ps1 missing" -ForegroundColor Red
    }

    $files = Get-ChildItem $e.FullName
    Write-Host " - Files: $($files.Count)" -ForegroundColor Cyan
}

Write-Host "`nEngine inspection complete." -ForegroundColor Green
