# DevAiCoreX Unified Deployment System
# Routes deployment commands to engines, workspaces, AI contexts, or game engines.

Write-Host "Loading DevAiCoreX unified deployment system..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function DevAi-Deploy {
    param(
        [string]$type,
        [string]$name
    )

    switch ($type) {
        "engine"     { . "$Global:DevAiRoot\devai-engine-deploy.ps1"; Deploy-Engine $name }
        "workspace"  { . "$Global:DevAiRoot\devai-workspace-deploy.ps1"; Deploy-Workspace $name }
        "ai"         { . "$Global:DevAiRoot\devai-ai-deploy.ps1"; Deploy-AIContext $name }
        "game"       { . "$Global:DevAiRoot\devai-game-deploy.ps1"; Deploy-GameEngine $name }
        default      { Write-Host "Unknown deploy type: $type" -ForegroundColor Red }
    }
}

Write-Host "Unified deployment system ready." -ForegroundColor Green
