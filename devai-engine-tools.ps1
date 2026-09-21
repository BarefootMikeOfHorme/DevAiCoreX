# DevAiCoreX Engine Tools
# Provides helpers for engine operations.

Write-Host "Loading DevAiCoreX engine tools..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function List-Engines {
    $root = "$Global:DevAiRoot\engines"
    if (Test-Path $root) {
        Write-Host "Available Engines:" -ForegroundColor Yellow
        Get-ChildItem $root -Directory | Select-Object Name
    } else {
        Write-Host "Engine directory missing." -ForegroundColor Red
    }
}

function Reload-Engines {
    Write-Host "Reloading engines..." -ForegroundColor Yellow
    . "$Global:DevAiRoot\engine-loader.ps1"
}

List-Engines

Write-Host "Engine tools ready." -ForegroundColor Green
