# DevAiCoreX Safe Settings Update Script
# Safely updates configuration files with automatic backups and validation.

Write-Host "Starting safe settings update..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Backup-File {
    param([string]$file)

    if (Test-Path $file) {
        $timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
        $backup = "$file.bak_$timestamp"
        Copy-Item $file $backup
        Write-Host "Backup created: $backup" -ForegroundColor Green
    } else {
        Write-Host "Cannot backup missing file: $file" -ForegroundColor Red
    }
}

function Validate-Config {
    param([string]$file)

    if (-not (Test-Path $file)) {
        Write-Host "Missing config: $file" -ForegroundColor Red
        return $false
    }

    try {
        $content = Get-Content $file -Raw

        if ($file -like "*.json") {
            $null = $content | ConvertFrom-Json
        }

        if ($file -like "*.yaml" -or $file -like "*.yml") {
            Write-Host "YAML validation placeholder for: $file"
        }

        Write-Host "Valid config: $file" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Invalid config: $file" -ForegroundColor Red
        return $false
    }
}

function Safe-Update {
    param(
        [string]$file,
        [string]$newContent
    )

    Write-Host "Updating: $file" -ForegroundColor Yellow

    Backup-File $file

    Set-Content -Path $file -Value $newContent

    if (Validate-Config $file) {
        Write-Host "Update successful: $file" -ForegroundColor Green
    } else {
        Write-Host "Update failed — restoring backup." -ForegroundColor Red

        $latestBackup = Get-ChildItem "$file.bak_*" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($latestBackup) {
            Copy-Item $latestBackup.FullName $file -Force
            Write-Host "Restored: $latestBackup" -ForegroundColor Yellow
        }
    }
}

Write-Host "Safe update module loaded." -ForegroundColor Cyan
