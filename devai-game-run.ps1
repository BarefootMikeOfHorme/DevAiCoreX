# DevAiCoreX Game Engine Runner
# Provides a unified way to run game engine-specific commands.

Write-Host "Loading DevAiCoreX game engine runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Run-GameEngine {
    param(
        [string]$engine,
        [string]$command
    )

    $enginePath = "$Global:DevAiRoot\game-engines\$engine"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Game engine not found: $engine" -ForegroundColor Red
        return
    }

    $runScript = "$enginePath\run.ps1"

    if (-not (Test-Path $runScript)) {
        Write-Host "Game engine has no run.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Running game engine command: $engine -> $command" -ForegroundColor Yellow
    . $runScript $command
}

Write-Host "Game engine runner ready." -ForegroundColor Green
