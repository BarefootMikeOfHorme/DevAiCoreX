# DevAiCoreX DevCShell Profile Installer
# Registers DevCShell as a PowerShell profile and integrates it with the global environment.

Write-Host "Installing DevCShell profile..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$devShellProfile = "$Global:DevAiRoot\DevCShell\DevCShell.ps1"

# Verify DevCShell exists
if (-not (Test-Path $devShellProfile)) {
    Write-Host "DevCShell.ps1 not found at: $devShellProfile" -ForegroundColor Red
    return
}

Write-Host "DevCShell found." -ForegroundColor Green

# Determine PowerShell profile path
$psProfilePath = $PROFILE

Write-Host "PowerShell profile path: $psProfilePath" -ForegroundColor Yellow

# Ensure profile file exists
if (-not (Test-Path $psProfilePath)) {
    Write-Host "Creating PowerShell profile..." -ForegroundColor Yellow
    New-Item -ItemType File -Path $psProfilePath -Force | Out-Null
}

# Add DevCShell loader to profile
$profileEntry = ". `"$devShellProfile`""

# Check if already added
$profileContent = Get-Content $psProfilePath -Raw

if ($profileContent -like "*DevCShell.ps1*") {
    Write-Host "DevCShell already registered in profile." -ForegroundColor Green
} else {
    Add-Content -Path $psProfilePath -Value $profileEntry
    Write-Host "DevCShell registered in PowerShell profile." -ForegroundColor Green
}

# Add global profile loader
$globalProfile = "$Global:DevAiRoot\global-profile.ps1"
$globalEntry = ". `"$globalProfile`""

if ($profileContent -like "*global-profile.ps1*") {
    Write-Host "Global profile already registered." -ForegroundColor Green
} else {
    Add-Content -Path $psProfilePath -Value $globalEntry
    Write-Host "Global profile registered." -ForegroundColor Green
}

# Provide activation alias
Set-Alias devshell "$devShellProfile"
Write-Host "Alias 'devshell' created." -ForegroundColor Yellow

Write-Host "DevCShell profile installation complete." -ForegroundColor Green
