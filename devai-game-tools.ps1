# DevAiCoreX Game Engine Tools
# Provides helpers for game engine operations.

Write-Host "Loading DevAiCoreX game engine tools..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function List-GameEngines {
    $root = "$Global:DevAiRoot\game-engines"
    if (Test-Path $root) {
        Write-Host "Available Game Engines:" -ForegroundColor Yellow
        Get-ChildItem $root -Directory | Select-Object Name
    } else {
        Write-Host "Game engine directory missing." -ForegroundColor Red
    }
}

function Reload-GameEngines {
    Write-Host "Reloading game engines..." -ForegroundColor Yellow
    . "$Global:DevAiRoot\game-engine-loader.ps1"
}

List-GameEngines

Write-Host "Game engine tools ready." -ForegroundColor Green
