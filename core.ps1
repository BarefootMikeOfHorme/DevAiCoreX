
# DevAiCoreX Core Initialization Script
# Loads environment, verifies core directories, and prepares system for loaders and shells.

Write-Host 'Loading environment...' -ForegroundColor Cyan
. "$Global:DevAiRoot\environment.ps1"

# Required core directories
$coreDirs = @(
    "$Global:DevAiRoot\engines",
    "$Global:DevAiRoot\workspaces",
    "$Global:DevAiRoot\profiles",
    "$Global:DevAiRoot\scripts",
    "$Global:DevAiRoot\toolchain",
    "$Global:DevAiRoot\ai-context",
    "$Global:DevAiRoot\game-engines"
)

Write-Host 'Verifying core directories...' -ForegroundColor Yellow
foreach ($dir in $coreDirs) {
    if (Test-Path $dir) {
        Write-Host "OK: $dir" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $dir" -ForegroundColor Red
    }
}

# Prepare loader scripts
$loaders = @(
    "engine-loader.ps1",
    "workspace-loader.ps1",
    "ai-context-loader.ps1",
    "game-engine-loader.ps1",
    "profile-loader.ps1"
)

Write-Host 'Checking loader scripts...' -ForegroundColor Yellow
foreach ($loader in $loaders) {
    $loaderPath = "$Global:DevAiRoot\$loader"
    if (Test-Path $loaderPath) {
        Write-Host "OK: $loader" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $loader" -ForegroundColor Red
    }
}

# Shell system check
$shells = @(
    "DevCShell",
    "wpshell"
)

Write-Host 'Checking shell directories...' -ForegroundColor Yellow
foreach ($shell in $shells) {
    $shellPath = "$Global:DevAiRoot\$shell"
    if (Test-Path $shellPath) {
        Write-Host "OK: $shell" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $shell" -ForegroundColor Red
    }
}

Write-Host 'Core initialization complete.' -ForegroundColor Green
