# DevAiCoreX Workspace Tools
# Provides helpers for workspace operations.

Write-Host "Loading DevAiCoreX workspace tools..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function List-Workspaces {
    $root = "$Global:DevAiRoot\workspaces"
    if (Test-Path $root) {
        Write-Host "Available Workspaces:" -ForegroundColor Yellow
        Get-ChildItem $root -Directory | Select-Object Name
    } else {
        Write-Host "Workspace directory missing." -ForegroundColor Red
    }
}

function Reload-Workspaces {
    Write-Host "Reloading workspaces..." -ForegroundColor Yellow
    . "$Global:DevAiRoot\workspace-loader.ps1"
}

List-Workspaces

Write-Host "Workspace tools ready." -ForegroundColor Green
