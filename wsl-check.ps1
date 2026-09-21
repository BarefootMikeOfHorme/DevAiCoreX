# DevAiCoreX WSL Check
# Detects WSL installation, distributions, and integration status.

Write-Host "Checking WSL status..." -ForegroundColor Cyan

# Check if WSL is installed
$wslInfo = wsl.exe --status 2>$null

if ($LASTEXITCODE -ne 0) {
    Write-Host "WSL is not installed." -ForegroundColor Red
    return
}

Write-Host "WSL is installed." -ForegroundColor Green

# List distros
Write-Host "Available WSL distributions:" -ForegroundColor Yellow
wsl.exe --list --verbose

Write-Host "WSL check complete." -ForegroundColor Green
