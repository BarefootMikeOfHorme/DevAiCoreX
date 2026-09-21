# DevAiCoreX Diagnostics Module
# Provides system, environment, and framework diagnostics.

Write-Host "Running DevAiCoreX diagnostics..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Check-DevAiRoot {
    if (Test-Path $Global:DevAiRoot) {
        Write-Host "Root OK: $Global:DevAiRoot" -ForegroundColor Green
    } else {
        Write-Host "Root missing: $Global:DevAiRoot" -ForegroundColor Red
    }
}

function Check-PowerShellVersion {
    $ver = $PSVersionTable.PSVersion
    Write-Host "PowerShell Version: $ver" -ForegroundColor Yellow
}

function Check-Modules {
    Write-Host "Loaded modules:" -ForegroundColor Cyan
    Get-Module | Select-Object Name, Version
}

Check-DevAiRoot
Check-PowerShellVersion
Check-Modules

Write-Host "Diagnostics complete." -ForegroundColor Green
