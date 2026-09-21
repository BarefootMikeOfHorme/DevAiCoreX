# DevAiCoreX Workspace Inspector
# Shows detailed information about each workspace folder.

Write-Host "Inspecting DevAiCoreX workspaces..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\workspaces"

if (-not (Test-Path $root)) {
    Write-Host "Workspace directory missing." -ForegroundColor Red
    return
}

$workspaces = Get-ChildItem $root -Directory

foreach ($w in $workspaces) {
    Write-Host "`nWorkspace: $($w.Name)" -ForegroundColor Yellow
    $bootstrap = Join-Path $w.FullName "bootstrap.ps1"
    if (Test-Path $bootstrap) {
        Write-Host " - bootstrap.ps1 found" -ForegroundColor Green
    } else {
        Write-Host " - bootstrap.ps1 missing" -ForegroundColor Red
    }

    $files = Get-ChildItem $w.FullName
    Write-Host " - Files: $($files.Count)" -ForegroundColor Cyan
}

Write-Host "`nWorkspace inspection complete." -ForegroundColor Green
