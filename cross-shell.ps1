# DevAiCoreX Cross-Shell Integration
# Provides helpers for switching between DevCShell, PowerShell, CMD, and WSL.

Write-Host "Loading cross-shell integration..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Use-DevCShell {
    Write-Host "Switching to DevCShell..." -ForegroundColor Yellow
    . "$Global:DevAiRoot\DevCShell\DevCShell.ps1"
}

function Use-PowerShell {
    Write-Host "Launching new PowerShell session..." -ForegroundColor Yellow
    powershell.exe
}

function Use-CMD {
    Write-Host "Launching CMD..." -ForegroundColor Yellow
    cmd.exe
}

function Use-WSL {
    Write-Host "Launching WSL..." -ForegroundColor Yellow
    wsl.exe
}

Write-Host "Cross-shell module ready." -ForegroundColor Green
