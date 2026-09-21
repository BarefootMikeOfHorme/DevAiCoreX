# DevAiCoreX Game Engine Test Runner
# Runs game engine-specific test scripts if present.

Write-Host "Loading DevAiCoreX game engine test runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Test-GameEngine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\game-engines\$engine"
    $testScript = "$enginePath\test.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Game engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $testScript)) {
        Write-Host "Game engine has no test.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Running game engine tests: $engine" -ForegroundColor Yellow
    . $testScript
}

Write-Host "Game engine test runner ready." -ForegroundColor Green
