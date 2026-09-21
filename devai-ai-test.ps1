# DevAiCoreX AI Context Test Runner
# Runs AI context-specific test scripts if present.

Write-Host "Loading DevAiCoreX AI test runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Test-AIContext {
    param([string]$context)

    $contextPath = "$Global:DevAiRoot\ai-context\$context"
    $testScript = "$contextPath\test.ps1"

    if (-not (Test-Path $contextPath)) {
        Write-Host "AI context not found: $context" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $testScript)) {
        Write-Host "AI context has no test.ps1: $context" -ForegroundColor Red
        return
    }

    Write-Host "Running AI context tests: $context" -ForegroundColor Yellow
    . $testScript
}

Write-Host "AI test runner ready." -ForegroundColor Green
