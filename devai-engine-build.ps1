# DevAiCoreX Engine Build Helper
# Provides unified build commands for engines.

Write-Host "Loading DevAiCoreX engine build helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Build-Engine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\engines\$engine"
    $buildScript = "$enginePath\build.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $buildScript)) {
        Write-Host "Engine has no build.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Building engine: $engine" -ForegroundColor Yellow
    . $buildScript
}

Write-Host "Engine build helper ready." -ForegroundColor Green
