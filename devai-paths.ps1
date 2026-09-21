# DevAiCoreX PATH Inspector
# Shows all PATH entries related to DevAiCoreX.

Write-Host "Inspecting DevAiCoreX PATH entries..." -ForegroundColor Cyan

$paths = $env:PATH -split ";"
foreach ($p in $paths) {
    if ($p -like "*DevAiCoreX*") {
        Write-Host " - $p" -ForegroundColor Green
    }
}

Write-Host "PATH inspection complete." -ForegroundColor Green
