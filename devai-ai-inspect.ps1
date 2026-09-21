# DevAiCoreX AI Context Inspector
# Shows detailed information about each AI context folder.

Write-Host "Inspecting DevAiCoreX AI contexts..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\ai-context"

if (-not (Test-Path $root)) {
    Write-Host "AI context directory missing." -ForegroundColor Red
    return
}

$contexts = Get-ChildItem $root -Directory

foreach ($c in $contexts) {
    Write-Host "`nAI Context: $($c.Name)" -ForegroundColor Yellow
    $bootstrap = Join-Path $c.FullName "bootstrap.ps1"
    if (Test-Path $bootstrap) {
        Write-Host " - bootstrap.ps1 found" -ForegroundColor Green
    } else {
        Write-Host " - bootstrap.ps1 missing" -ForegroundColor Red
    }

    $files = Get-ChildItem $c.FullName
    Write-Host " - Files: $($files.Count)" -ForegroundColor Cyan
}

Write-Host "`nAI context inspection complete." -ForegroundColor Green
