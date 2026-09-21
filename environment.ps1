
# DevAiCoreX Environment Initialization Script
# Sets global paths, environment variables, and verifies core system readiness.

Write-Host 'Initializing DevAiCoreX environment...' -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

# Core directories to inject into PATH
$paths = @(
    "$Global:DevAiRoot\engines",
    "$Global:DevAiRoot\workspaces",
    "$Global:DevAiRoot\scripts",
    "$Global:DevAiRoot\profiles",
    "$Global:DevAiRoot\toolchain"
)

Write-Host 'Updating PATH entries...' -ForegroundColor Yellow
foreach ($p in $paths) {
    if (-not ($env:PATH -like "*$p*")) {
        $env:PATH += ";$p"
        Write-Host "Added: $p"
    } else {
        Write-Host "Exists: $p"
    }
}

# Basic system checks
Write-Host "Performing system checks..." -ForegroundColor Yellow

# Check PowerShell version
$psver = $PSVersionTable.PSVersion.Major
Write-Host "PowerShell Version: $psver"
if ($psver -lt 5) { Write-Host "WARNING: PowerShell 5+ recommended." -ForegroundColor Red }

# Check if DevAiCoreX root exists
if (-not (Test-Path $Global:DevAiRoot)) {
    Write-Host "ERROR: DevAiCoreX root directory missing!" -ForegroundColor Red
} else {
    Write-Host "Root directory verified." -ForegroundColor Green
}

Write-Host 'Environment initialization complete.' -ForegroundColor Green
