# DevAiCoreX AI Tools
# Provides helpers for AI context operations.

Write-Host "Loading DevAiCoreX AI tools..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function List-AIContexts {
    $root = "$Global:DevAiRoot\ai-context"
    if (Test-Path $root) {
        Write-Host "Available AI Contexts:" -ForegroundColor Yellow
        Get-ChildItem $root -Directory | Select-Object Name
    } else {
        Write-Host "AI context directory missing." -ForegroundColor Red
    }
}

function Reload-AIContexts {
    Write-Host "Reloading AI contexts..." -ForegroundColor Yellow
    . "$Global:DevAiRoot\ai-context-loader.ps1"
}

List-AIContexts

Write-Host "AI tools ready." -ForegroundColor Green
