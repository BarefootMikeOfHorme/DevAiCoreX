# DevAiCoreX Game Engine Inspector
# Shows detailed information about each game engine folder.

Write-Host "Inspecting DevAiCoreX game engines..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\game-engines"

if (-not (Test-Path $root)) {
    Write-Host "Game engine directory missing." -ForegroundColor Red
    return
}

$engines = Get-ChildItem $root -Directory

foreach ($g in $engines) {
    Write-Host "`nGame Engine: $($g.Name)" -ForegroundColor Yellow
    $bootstrap = Join-Path $g.FullName "bootstrap.ps1"
    if (Test-Path $bootstrap) {
        Write-Host " - bootstrap.ps1 found" -ForegroundColor Green
    } else {
        Write-Host " - bootstrap.ps1 missing" -ForegroundColor Red
    }

    $files = Get-ChildItem $g.FullName
    Write-Host " - Files: $($files.Count)" -ForegroundColor Cyan
}

Write-Host "`nGame engine inspection complete." -ForegroundColor Green
