# DevAiCoreX DevShell Aliases
# Provides command shortcuts for DevCShell users.

Write-Host "Loading DevShell aliases..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

Set-Alias daix "$Global:DevAiRoot\startup-menu.ps1"
Set-Alias daix-engines "$Global:DevAiRoot\engine-loader.ps1"
Set-Alias daix-workspaces "$Global:DevAiRoot\workspace-loader.ps1"
Set-Alias daix-ai "$Global:DevAiRoot\ai-context-loader.ps1"
Set-Alias daix-diagnostics "$Global:DevAiRoot\diagnostics.ps1"

Write-Host "DevShell aliases loaded." -ForegroundColor Green
