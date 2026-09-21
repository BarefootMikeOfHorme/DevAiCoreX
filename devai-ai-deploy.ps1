# DevAiCoreX AI Context Deployment Helper
# Provides unified deployment commands for AI contexts.

Write-Host "Loading DevAiCoreX AI deployment helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Deploy-AIContext {
    param([string]$context)

    $contextPath = "$Global:DevAiRoot\ai-context\$context"
    $deployScript = "$contextPath\deploy.ps1"

    if (-not (Test-Path $contextPath)) {
        Write-Host "AI context not found: $context" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $deployScript)) {
        Write-Host "AI context has no deploy.ps1: $context" -ForegroundColor Red
        return
    }

    Write-Host "Deploying AI context: $context" -ForegroundColor Yellow
    . $deployScript
}

Write-Host "AI deployment helper ready." -ForegroundColor Green
