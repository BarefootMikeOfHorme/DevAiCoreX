# DevAiCoreX Profile Inspector
# Shows status of all profile scripts in the root.

Write-Host "Inspecting DevAiCoreX profiles..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

$profiles = @(
    "global-profile.ps1",
    "vs2022-profile.ps1",
    "add-devshell-profile.ps1",
    "profile-loader.ps1",
    "devai-shell-profile.ps1",
    "devai-bootstrap.ps1"
)

foreach ($p in $profiles) {
    $path = Join-Path $root $p
    if (Test-Path $path) {
        Write-Host "OK: $p" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $p" -ForegroundColor Red
    }
}

Write-Host "`nProfile inspection complete." -ForegroundColor Green
