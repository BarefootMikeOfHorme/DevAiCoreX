# DevAiCoreX Restore Utility
# Restores from the latest full backup.

Write-Host "Restoring DevAiCoreX from latest backup..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$backupRoot = "$Global:DevAiRoot\full-backups"

if (-not (Test-Path $backupRoot)) {
    Write-Host "No backup directory found." -ForegroundColor Red
    return
}

$latest = Get-ChildItem $backupRoot | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $latest) {
    Write-Host "No backups available." -ForegroundColor Red
    return
}

Write-Host "Restoring from: $($latest.FullName)" -ForegroundColor Yellow

Copy-Item "$($latest.FullName)\DevAiCoreX" $Global:DevAiRoot -Recurse -Force

Write-Host "Restore complete." -ForegroundColor Green
