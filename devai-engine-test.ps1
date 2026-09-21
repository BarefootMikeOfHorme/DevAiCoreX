# DevAiCoreX Engine Test Runner
# Runs engine-specific test scripts if present.

Write-Host "Loading DevAiCoreX engine test runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Test-Engine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\engines\$engine"
    $testScript = "$enginePath\test.ps1"

    if (-not (Test-Path $enginePath)) {
        Write-Host "Engine not found: $engine" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $testScript)) {
        Write-Host "Engine has no test.ps1: $engine" -ForegroundColor Red
        return
    }

    Write-Host "Running engine tests: $engine" -ForegroundColor Yellow
    . $testScript
}

Write-Host "Engine test runner ready." -ForegroundColor Green
