# DevAiCoreX AI Build Helper
# Provides unified build commands for AI contexts.

Write-Host "Loading DevAiCoreX AI build helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Build-AIContext {
    param([string]$context)

    $contextPath = "$Global:DevAiRoot\ai-context\$context"
    $buildScript = "$contextPath\build.ps1"

    if (-not (Test-Path $contextPath)) {
        Write-Host "AI context not found: $context" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $buildScript)) {
        Write-Host "AI context has no build.ps1: $context" -ForegroundColor Red
        return
    }

    Write-Host "Building AI context: $context" -ForegroundColor Yellow
    . $buildScript
}

Write-Host "AI build helper ready." -ForegroundColor Green
