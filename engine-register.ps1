# DevAiCoreX Engine Registration
# Allows engines to self-register into the framework.

Write-Host "Engine registration module loaded..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$registry = "$Global:DevAiRoot\engines\engine-registry.json"

if (-not (Test-Path $registry)) {
    "{}" | Set-Content $registry
}

function Register-Engine {
    param(
        [string]$name,
        [string]$path
    )

    $json = Get-Content $registry -Raw | ConvertFrom-Json
    $json.$name = $path
    $json | ConvertTo-Json -Depth 5 | Set-Content $registry

    Write-Host "Engine registered: $name" -ForegroundColor Green
}

Write-Host "Engine registration ready." -ForegroundColor Green
