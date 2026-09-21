# DevAiCoreX Workspace Test Runner
# Runs workspace-specific test scripts if present.

Write-Host "Loading DevAiCoreX workspace test runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Test-Workspace {
    param([string]$workspace)

    $workspacePath = "$Global:DevAiRoot\workspaces\$workspace"
    $testScript = "$workspacePath\test.ps1"

    if (-not (Test-Path $workspacePath)) {
        Write-Host "Workspace not found: $workspace" -ForegroundColor Red
        return
    }

    if (-not (Test-Path $testScript)) {
        Write-Host "Workspace has no test.ps1: $workspace" -ForegroundColor Red
        return
    }

    Write-Host "Running workspace tests: $workspace" -ForegroundColor Yellow
    . $testScript
}

Write-Host "Workspace test runner ready." -ForegroundColor Green
