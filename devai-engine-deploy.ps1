# DevAiCoreX Engine Deployment Helper
# Provides unified deployment commands for engines.

Write-Host "Loading DevAiCoreX engine deployment helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Deploy-Engine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\engines\$engine"
    $deployScript = "$enginePath\deploy.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $deployScript)) {
        Write-Host "Engine has no deploy.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Deploying engine: $engine" -ForegroundColor Yellow
    . $deployScript
}

Write-Host "Engine deployment helper ready." -ForegroundColor Green
