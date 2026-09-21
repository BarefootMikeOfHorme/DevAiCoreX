# DevAiCoreX Unified Runner
# Routes run commands to engines, workspaces, AI contexts, or game engines.

Write-Host "Loading DevAiCoreX unified runner..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function DevAi-Run {
    param(
        [string]$type,
        [string]$name,
        [string]$command
    )

    switch ($type) {
        "engine"     { . "$Global:DevAiRoot\devai-engine-run.ps1"; Run-Engine $name $command }
        "workspace"  { . "$Global:DevAiRoot\devai-workspace-run.ps1"; Run-Workspace $name $command }
        "ai"         { . "$Global:DevAiRoot\devai-ai-run.ps1"; Run-AIContext $name $command }
        "game"       { . "$Global:DevAiRoot\devai-game-run.ps1"; Run-GameEngine $name $command }
        default      { Write-Host "Unknown type: $type" -ForegroundColor Red }
    }
}

Write-Host "Unified runner ready." -ForegroundColor Green
