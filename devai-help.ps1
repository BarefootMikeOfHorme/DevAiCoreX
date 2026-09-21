# DevAiCoreX Help Module
# Displays available commands and modules.

Write-Host "DevAiCoreX Help" -ForegroundColor Cyan
Write-Host "================" -ForegroundColor Cyan

function Show-DevAiHelp {
    Write-Host ""
    Write-Host "Core Commands:"
    Write-Host "  daix                 - Launch startup menu"
    Write-Host "  daix-engines         - Load engines"
    Write-Host "  daix-workspaces      - Load workspaces"
    Write-Host "  daix-ai              - Load AI contexts"
    Write-Host "  daix-diagnostics     - Run diagnostics"
    Write-Host ""
    Write-Host "Modules:"
    Write-Host "  engine-loader.ps1"
    Write-Host "  workspace-loader.ps1"
    Write-Host "  ai-context-loader.ps1"
    Write-Host "  game-engine-loader.ps1"
    Write-Host "  diagnostics.ps1"
    Write-Host "  routing.ps1"
    Write-Host "  logging.ps1"
    Write-Host ""
}

Show-DevAiHelp
