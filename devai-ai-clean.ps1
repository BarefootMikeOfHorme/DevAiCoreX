# DevAiCoreX AI Context Cleanup Helper
# Cleans AI context temp, cache, and build artifacts.

Write-Host "Cleaning AI context artifacts..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Clean-AIContext {
    param([string]$context)

    $contextPath = "$Global:DevAiRoot\ai-context\$context"
    $targets = @("temp", "cache", "build")

    if (-not (Test-Path $contextPath)) {
        Write-Host "AI context not found: $context" -ForegroundColor Red
        return
    }

    foreach ($t in $targets) {
        $p = "$contextPath\$t"
        if (Test-Path $p) {
            Write-Host "Cleaning: $p" -ForegroundColor Yellow
            Remove-Item $p -Recurse -Force
            New-Item -ItemType Directory -Path $p | Out-Null
        }
    }

    Write-Host "AI context cleanup complete: $context" -ForegroundColor Green
}

Write-Host "AI cleanup helper ready." -ForegroundColor Green
