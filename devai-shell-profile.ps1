# DevAiCoreX Shell Profile
# Loads shell tools, aliases, and environment helpers.

Write-Host "Loading DevAiCoreX shell profile..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

# Load shell tools
if (Test-Path "$Global:DevAiRoot\devai-shell-tools.ps1") {
    . "$Global:DevAiRoot\devai-shell-tools.ps1"
}

# Load aliases
if (Test-Path "$Global:DevAiRoot\devshell-aliases.ps1") {
    . "$Global:DevAiRoot\devshell-aliases.ps1"
}

Write-Host "Shell profile loaded." -ForegroundColor Green
