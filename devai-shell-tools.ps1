# DevAiCoreX Shell Tools
# Provides helper commands for shell operations.

Write-Host "Loading DevAiCoreX shell tools..." -ForegroundColor Cyan

function Clear-Screen {
    cls
    Write-Host "Screen cleared." -ForegroundColor Yellow
}

function Reload-Shell {
    Write-Host "Reloading shell..." -ForegroundColor Yellow
    powershell.exe
}

function Restart-DevAi {
    Write-Host "Restarting DevAiCoreX..." -ForegroundColor Yellow
    . "C:\Users\Administrator\Desktop\DevAiCoreX\global-profile.ps1"
}

Write-Host "Shell tools ready." -ForegroundColor Green
