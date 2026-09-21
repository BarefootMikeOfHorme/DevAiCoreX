# DevAiCoreX Full Backup Utility
# Creates timestamped backups of all configs and profiles.

Write-Host "Running full DevAiCoreX backup..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$backupRoot = "$Global:DevAiRoot\full-backups"

if (-not (Test-Path $backupRoot)) {
    New-Item -ItemType Directory -Path $backupRoot | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupDir = "$backupRoot\backup_$timestamp"

New-Item -ItemType Directory -Path $backupDir | Out-Null

Copy-Item $Global:DevAiRoot $backupDir -Recurse -Force

Write-Host "Full backup created at: $backupDir" -ForegroundColor Green
