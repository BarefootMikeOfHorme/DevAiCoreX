# DevAiCoreX Global PowerShell Profile
# Loads environment, core systems, routing, and global aliases.

Write-Host "Loading DevAiCoreX global profile..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

# Load environment
if (Test-Path "$Global:DevAiRoot\environment.ps1") {
    . "$Global:DevAiRoot\environment.ps1"
    Write-Host "Environment loaded." -ForegroundColor Green
} else {
    Write-Host "Missing environment.ps1" -ForegroundColor Red
}

# Load core
if (Test-Path "$Global:DevAiRoot\core.ps1") {
    . "$Global:DevAiRoot\core.ps1"
    Write-Host "Core loaded." -ForegroundColor Green
} else {
    Write-Host "Missing core.ps1" -ForegroundColor Red
}

# Load routing
if (Test-Path "$Global:DevAiRoot\routing.ps1") {
    . "$Global:DevAiRoot\routing.ps1"
    Write-Host "Routing loaded." -ForegroundColor Green
} else {
    Write-Host "Missing routing.ps1" -ForegroundColor Red
}

# Global aliases
Set-Alias daix "$Global:DevAiRoot\startup-menu.ps1"
Set-Alias daix-core "$Global:DevAiRoot\core.ps1"
Set-Alias daix-env "$Global:DevAiRoot\environment.ps1"

Write-Host "Global aliases registered." -ForegroundColor Yellow

# Global functions
function daix-reload {
    Write-Host "Reloading DevAiCoreX..." -ForegroundColor Cyan
    . "$Global:DevAiRoot\global-profile.ps1"
}

function daix-paths {
    Write-Host "DevAiCoreX PATH entries:" -ForegroundColor Cyan
    $env:PATH -split ";" | Where-Object { $_ -like "*DevAiCoreX*" }
}

Write-Host "DevAiCoreX global profile loaded successfully." -ForegroundColor Green
