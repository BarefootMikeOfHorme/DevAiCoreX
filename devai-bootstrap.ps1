# DevAiCoreX Bootstrap
# Loads all core modules in correct order.

Write-Host "Bootstrapping DevAiCoreX..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

$modules = @(
    "environment.ps1",
    "core.ps1",
    "routing.ps1",
    "logging.ps1",
    "validation.ps1",
    "devai-shell-profile.ps1",
    "engine-loader.ps1",
    "workspace-loader.ps1",
    "ai-context-loader.ps1",
    "game-engine-loader.ps1"
)

foreach ($m in $modules) {
    $path = "$Global:DevAiRoot\$m"
    if (Test-Path $path) {
        Write-Host "Loading: $m" -ForegroundColor Yellow
        . $path
    } else {
        Write-Host "Missing: $m" -ForegroundColor Red
    }
}

Write-Host "DevAiCoreX bootstrap complete." -ForegroundColor Green
