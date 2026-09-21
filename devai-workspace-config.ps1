# DevAiCoreX Workspace Config Manager
# Loads and validates workspace configuration files.

Write-Host "Loading DevAiCoreX workspace config manager..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Load-WorkspaceConfig {
    param([string]$workspace)

    $configPath = "$Global:DevAiRoot\workspaces\$workspace\config.json"

    if (-not (Test-Path $configPath)) {
        Write-Host "Workspace config missing: $configPath" -ForegroundColor Red
        return $null
    }

    try {
        $json = Get-Content $configPath -Raw | ConvertFrom-Json
        Write-Host "Loaded config for workspace: $workspace" -ForegroundColor Green
        return $json
    } catch {
        Write-Host "Invalid JSON in workspace config: $workspace" -ForegroundColor Red
        return $null
    }
}

Write-Host "Workspace config manager ready." -ForegroundColor Green
