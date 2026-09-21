# DevAiCoreX Engine Runner
# Provides a unified way to run engine-specific commands.

Write-Host "Loading DevAiCoreX engine runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Run-Engine {
    param(
        [string]$engine,
        [string]$command
    )

    $enginePath = "$Global:DevAiRoot\engines\$engine"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Engine not found: $engine" -ForegroundColor Red
        return
    }

    $runScript = "$enginePath\run.ps1"

    if (-not (Test-Path $runScript)) {
        Write-Host "Engine has no run.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Running engine command: $engine -> $command" -ForegroundColor Yellow
    . $runScript $command
}

Write-Host "Engine runner ready." -ForegroundColor Green
