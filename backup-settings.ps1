# DevAiCoreX Backup Settings Script
# Creates timestamped backups of configuration files.

Write-Host "Backup module loaded..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Backup-Settings {
    param([string]$file)

    if (-not (Test-Path $file)) {
        Write-Host "Cannot backup missing file: $file" -ForegroundColor Red
        return
    }

    $timestamp = (Get-Date).ToString("yyyyMMdd_HHmmss")
    $backup = "$file.bak_$timestamp"

    try {
        Copy-Item $file $backup -Force
        Write-Host "Backup created: $backup" -ForegroundColor Green
    }
    catch {
        Write-Host "Backup failed for: $file" -ForegroundColor Red
    }
}

Write-Host "Backup settings module ready." -ForegroundColor Green
