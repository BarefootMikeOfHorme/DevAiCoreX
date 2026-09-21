# DevAiCoreX Unified Cleanup System
# Routes cleanup commands to engines, workspaces, AI contexts, or game engines.

Write-Host "Loading DevAiCoreX unified cleanup system..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function DevAi-Clean {
    param(
        [string]$type,
        [string]$name
    )

    switch ($type) {
        "engine"     { . "$Global:DevAiRoot\devai-engine-clean.ps1"; Clean-Engine $name }
        "workspace"  { . "$Global:DevAiRoot\devai-workspace-clean.ps1"; Clean-Workspace $name }
        "ai"         { . "$Global:DevAiRoot\devai-ai-clean.ps1"; Clean-AIContext $name }
        "game"       { . "$Global:DevAiRoot\devai-game-clean.ps1"; Clean-GameEngine $name }
        default      { Write-Host "Unknown cleanup type: $type" -ForegroundColor Red }
    }
}

Write-Host "Unified cleanup system ready." -ForegroundColor Green
