# DevAiCoreX Game Engine Deployment Helper
# Provides unified deployment commands for game engines.

Write-Host "Loading DevAiCoreX game engine deployment helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Deploy-GameEngine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\game-engines\$engine"
    $deployScript = "$enginePath\deploy.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Game engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $deployScript)) {
        Write-Host "Game engine has no deploy.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Deploying game engine: $engine" -ForegroundColor Yellow
    . $deployScript
}

Write-Host "Game engine deployment helper ready." -ForegroundColor Green
