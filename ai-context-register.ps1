# DevAiCoreX AI Context Registration
# Allows AI contexts to self-register into the framework.

Write-Host "AI context registration module loaded..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$registry = "$Global:DevAiRoot\ai-context\ai-registry.json"

if (-not (Test-Path $registry)) {
    "{}" | Set-Content $registry
}

function Register-AIContext {
    param(
        [string]$name,
        [string]$path
    )

    $json = Get-Content $registry -Raw | ConvertFrom-Json
    $json.$name = $path
    $json | ConvertTo-Json -Depth 5 | Set-Content $registry

    Write-Host "AI context registered: $name" -ForegroundColor Green
}

Write-Host "AI context registration ready." -ForegroundColor Green
