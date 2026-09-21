# DevAiCoreX Engine Config Manager
# Loads and validates engine configuration files.

Write-Host "Loading DevAiCoreX engine config manager..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Load-EngineConfig {
    param([string]$engine)

    $configPath = "$Global:DevAiRoot\engines\$engine\config.json"

    if (-not (Test-Path $configPath)) {
        Write-Host "Engine config missing: $configPath" -ForegroundColor Red
        return $null
    }

    try {
        $json = Get-Content $configPath -Raw | ConvertFrom-Json
        Write-Host "Loaded config for engine: $engine" -ForegroundColor Green
        return $json
    } catch {
        Write-Host "Invalid JSON in engine config: $engine" -ForegroundColor Red
        return $null
    }
}

Write-Host "Engine config manager ready." -ForegroundColor Green
