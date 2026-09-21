# DevAiCoreX Validation Module
# Provides basic validation helpers for configs, paths, and environment.

Write-Host "Loading DevAiCoreX validation module..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Validate-PathExists {
    param([string]$path)

    if (Test-Path $path) {
        Write-Host "Path exists: $path" -ForegroundColor Green
        return $true
    } else {
        Write-Host "Missing path: $path" -ForegroundColor Red
        return $false
    }
}

function Validate-JsonFile {
    param([string]$file)

    if (-not (Test-Path $file)) {
        Write-Host "JSON file missing: $file" -ForegroundColor Red
        return $false
    }

    try {
        $content = Get-Content $file -Raw
        $null = $content | ConvertFrom-Json
        Write-Host "Valid JSON: $file" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Invalid JSON: $file" -ForegroundColor Red
        return $false
    }
}

Write-Host "Validation module ready." -ForegroundColor Green
