# DevAiCoreX Workspace Cleanup Helper
# Cleans workspace temp, cache, and build artifacts.

Write-Host "Cleaning workspace artifacts..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Clean-Workspace {
    param([string]$workspace)

    $workspacePath = "$Global:DevAiRoot\workspaces\$workspace"
    $targets = @("temp", "cache", "build")

    if (-not (Test-Path $workspacePath)) {
        Write-Host "Workspace not found: $workspace" -ForegroundColor Red
        return
    }

    foreach ($t in $targets) {
        $p = "$workspacePath\$t"
        if (Test-Path $p) {
            Write-Host "Cleaning: $p" -ForegroundColor Yellow
            Remove-Item $p -Recurse -Force
            New-Item -ItemType Directory -Path $p | Out-Null
        }
    }

    Write-Host "Workspace cleanup complete: $workspace" -ForegroundColor Green
}

Write-Host "Workspace cleanup helper ready." -ForegroundColor Green
