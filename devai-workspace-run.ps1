# DevAiCoreX Workspace Runner
# Provides a unified way to run workspace-specific commands.

Write-Host "Loading DevAiCoreX workspace runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Run-Workspace {
    param(
        [string]$workspace,
        [string]$command
    )

    $workspacePath = "$Global:DevAiRoot\workspaces\$workspace"

    if (-not (Test-Path $workspacePath)) {
        Write-Host "Workspace not found: $workspace" -ForegroundColor Red
        return
    }

    $runScript = "$workspacePath\run.ps1"

    if (-not (Test-Path $runScript)) {
        Write-Host "Workspace has no run.ps1: $workspace" -ForegroundColor Red
        return
    }

    Write-Host "Running workspace command: $workspace -> $command" -ForegroundColor Yellow
    . $runScript $command
}

Write-Host "Workspace runner ready." -ForegroundColor Green
