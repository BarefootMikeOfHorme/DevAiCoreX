# DevAiCoreX Unified Build System
# Routes build commands to engines, workspaces, AI contexts, or game engines.

Write-Host "Loading DevAiCoreX unified build system..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function DevAi-Build {
    param(
        [string]$type,
        [string]$name
    )

    switch ($type) {
        "engine"     { . "$Global:DevAiRoot\devai-engine-build.ps1"; Build-Engine $name }
        "workspace"  { . "$Global:DevAiRoot\devai-workspace-build.ps1"; Build-Workspace $name }
        "ai"         { . "$Global:DevAiRoot\devai-ai-build.ps1"; Build-AIContext $name }
        "game"       { . "$Global:DevAiRoot\devai-game-build.ps1"; Build-GameEngine $name }
        default      { Write-Host "Unknown build type: $type" -ForegroundColor Red }
    }
}

Write-Host "Unified build system ready." -ForegroundColor Green
