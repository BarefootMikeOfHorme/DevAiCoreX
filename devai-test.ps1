# DevAiCoreX Unified Test System
# Routes test commands to engines, workspaces, AI contexts, or game engines.

Write-Host "Loading DevAiCoreX unified test system..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function DevAi-Test {
    param(
        [string]$type,
        [string]$name
    )

    switch ($type) {
        "engine"     { . "$Global:DevAiRoot\devai-engine-test.ps1"; Test-Engine $name }
        "workspace"  { . "$Global:DevAiRoot\devai-workspace-test.ps1"; Test-Workspace $name }
        "ai"         { . "$Global:DevAiRoot\devai-ai-test.ps1"; Test-AIContext $name }
        "game"       { . "$Global:DevAiRoot\devai-game-test.ps1"; Test-GameEngine $name }
        default      { Write-Host "Unknown test type: $type" -ForegroundColor Red }
    }
}

Write-Host "Unified test system ready." -ForegroundColor Green
