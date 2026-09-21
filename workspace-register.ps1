# DevAiCoreX Workspace Registration
# Allows workspaces to self-register into the framework.

Write-Host "Workspace registration module loaded..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$registry = "$Global:DevAiRoot\workspaces\workspace-registry.json"

if (-not (Test-Path $registry)) {
    "{}" | Set-Content $registry
}

function Register-Workspace {
    param(
        [string]$name,
        [string]$path
    )

    $json = Get-Content $registry -Raw | ConvertFrom-Json
    $json.$name = $path
    $json | ConvertTo-Json -Depth 5 | Set-Content $registry

    Write-Host "Workspace registered: $name" -ForegroundColor Green
}

Write-Host "Workspace registration ready." -ForegroundColor Green
