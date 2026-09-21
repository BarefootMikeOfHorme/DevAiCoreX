# DevAiCoreX Game Engine Build Helper
# Provides unified build commands for game engines.

Write-Host "Loading DevAiCoreX game engine build helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Build-GameEngine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\game-engines\$engine"
    $buildScript = "$enginePath\build.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Game engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $buildScript)) {
        Write-Host "Game engine has no build.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Building game engine: $engine" -ForegroundColor Yellow
    . $buildScript
}

Write-Host "Game engine build helper ready." -ForegroundColor Green
