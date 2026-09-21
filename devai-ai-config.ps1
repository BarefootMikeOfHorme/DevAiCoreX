# DevAiCoreX AI Context Config Manager
# Loads and validates AI context configuration files.

Write-Host "Loading DevAiCoreX AI config manager..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Load-AIConfig {
    param([string]$context)

    $configPath = "$Global:DevAiRoot\ai-context\$context\config.json"

    if (-not (Test-Path $configPath)) {
        Write-Host "AI context config missing: $configPath" -ForegroundColor Red
        return $null
    }

    try {
        $json = Get-Content $configPath -Raw | ConvertFrom-Json
        Write-Host "Loaded config for AI context: $context" -ForegroundColor Green
        return $json
    } catch {
        Write-Host "Invalid JSON in AI context config: $context" -ForegroundColor Red
        return $null
    }
}

Write-Host "AI config manager ready." -ForegroundColor Green
