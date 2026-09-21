# DevAiCoreX Workspace Deployment Helper
# Provides unified deployment commands for workspaces.

Write-Host "Loading DevAiCoreX workspace deployment helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Deploy-Workspace {
    param([string]$workspace)

    $workspacePath = "$Global:DevAiRoot\workspaces\$workspace"
    $deployScript = "$workspacePath\deploy.ps1"

    if (-not (Test-Path $workspacePath)) {
        Write-Host "Workspace not found: $workspace" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $deployScript)) {
        Write-Host "Workspace has no deploy.ps1: $workspace" -ForegroundColor Red
        return
    }

    Write-Host "Deploying workspace: $workspace" -ForegroundColor Yellow
    . $deployScript
}

Write-Host "Workspace deployment helper ready." -ForegroundColor Green
