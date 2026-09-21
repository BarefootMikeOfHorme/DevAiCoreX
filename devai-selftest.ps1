# DevAiCoreX Self-Test Module
# Runs a series of checks to validate framework integrity.

Write-Host "Running DevAiCoreX self-test..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

$checks = @(
    "$Global:DevAiRoot\core.ps1",
    "$Global:DevAiRoot\environment.ps1",
    "$Global:DevAiRoot\global-profile.ps1",
    "$Global:DevAiRoot\engine-loader.ps1",
    "$Global:DevAiRoot\workspace-loader.ps1",
    "$Global:DevAiRoot\ai-context-loader.ps1"
)

foreach ($c in $checks) {
    if (Test-Path $c) {
        Write-Host "OK: $c" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $c" -ForegroundColor Red
    }
}

Write-Host "Self-test complete." -ForegroundColor Green
