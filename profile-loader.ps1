# DevAiCoreX Profile Loader
# Loads all profiles: global, VS2022, DevCShell, engine/workspace profiles.

Write-Host "Loading DevAiCoreX profiles..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

# List of known profiles
$profiles = @(
    "global-profile.ps1",
    "vs2022-profile.ps1",
    "add-devshell-profile.ps1"
)

# Load core profiles
foreach ($profile in $profiles) {
    $path = "$Global:DevAiRoot\$profile"
    if (Test-Path $path) {
        Write-Host "Loading profile: $profile" -ForegroundColor Yellow
        . $path
        Write-Host "Loaded: $profile" -ForegroundColor Green
    } else {
        Write-Host "Missing profile: $profile" -ForegroundColor Red
    }
}

# Load engine profiles
$engineProfileDir = "$Global:DevAiRoot\engines\profiles"
if (Test-Path $engineProfileDir) {
    Write-Host "Loading engine profiles..." -ForegroundColor Cyan
    Get-ChildItem $engineProfileDir -Filter *.ps1 | ForEach-Object {
        Write-Host "Loading engine profile: $($_.Name)" -ForegroundColor Yellow
        . $_.FullName
    }
}

# Load workspace profiles
$workspaceProfileDir = "$Global:DevAiRoot\workspaces\profiles"
if (Test-Path $workspaceProfileDir) {
    Write-Host "Loading workspace profiles..." -ForegroundColor Cyan
    Get-ChildItem $workspaceProfileDir -Filter *.ps1 | ForEach-Object {
        Write-Host "Loading workspace profile: $($_.Name)" -ForegroundColor Yellow
        . $_.FullName
    }
}

Write-Host "All DevAiCoreX profiles loaded successfully." -ForegroundColor Green
