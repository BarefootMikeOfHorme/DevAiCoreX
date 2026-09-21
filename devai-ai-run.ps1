# DevAiCoreX AI Context Runner
# Provides a unified way to run AI context-specific commands.

Write-Host "Loading DevAiCoreX AI runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Run-AIContext {
    param(
        [string]$context,
        [string]$command
    )

    $contextPath = "$Global:DevAiRoot\ai-context\$context"

    if (-not (Test-Path $contextPath)) {
        Write-Host "AI context not found: $context" -ForegroundColor Red
        return
    }

    $runScript = "$contextPath\run.ps1"

    if (-not (Test-Path $runScript)) {
        Write-Host "AI context has no run.ps1: $context" -ForegroundColor Red
        return
    }

    Write-Host "Running AI context command: $context -> $command" -ForegroundColor Yellow
    . $runScript $command
}

Write-Host "AI runner ready." -ForegroundColor Green
