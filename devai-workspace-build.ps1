# DevAiCoreX Workspace Build Helper
# Provides unified build commands for workspaces.

Write-Host "Loading DevAiCoreX workspace build helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Build-Workspace {
    param([string]$workspace)

    $workspacePath = "$Global:DevAiRoot\workspaces\$workspace"
    $buildScript = "$workspacePath\build.ps1"

    if (-not (Test-Path $workspacePath)) {
        Write-Host "Workspace not found: $workspace" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $buildScript)) {
        Write-Host "Workspace has no build.ps1: $workspace" -ForegroundColor Red
        return
    }

    Write-Host "Building workspace: $workspace" -ForegroundColor Yellow
    . $buildScript
}

Write-Host "Workspace build helper ready." -ForegroundColor Green
