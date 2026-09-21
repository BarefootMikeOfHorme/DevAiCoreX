# DevAiCoreX Game Engine Config Manager
# Loads and validates game engine configuration files.

Write-Host "Loading DevAiCoreX game engine config manager..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Load-GameEngineConfig {
    param([string]$engine)

    $configPath = "$Global:DevAiRoot\game-engines\$engine\config.json"

    if (-not (Test-Path $configPath)) {
        Write-Host "Game engine config missing: $configPath" -ForegroundColor Red
        return $null
    }

    try {
        $json = Get-Content $configPath -Raw | ConvertFrom-Json
        Write-Host "Loaded config for game engine: $engine" -ForegroundColor Green
        return $json
    } catch {
        Write-Host "Invalid JSON in game engine config: $engine" -ForegroundColor Red
        return $null
    }
}

Write-Host "Game engine config manager ready." -ForegroundColor Green
