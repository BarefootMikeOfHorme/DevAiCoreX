Write-Host "[RESTORE] Restoring DevAiCoreX project..."

if (-not (Test-Path "./backup")) {
    Write-Host "[RESTORE] No backup directory found."
    exit 1
}

Write-Host "[RESTORE] Restoring files from backup..."

Copy-Item "./backup/*" "./" -Recurse -Force

Write-Host "[RESTORE] Restore complete."
