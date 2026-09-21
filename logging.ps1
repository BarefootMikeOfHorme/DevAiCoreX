# DevAiCoreX Logging Module
# Provides simple file-based logging for DevAiCoreX components.

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$Global:DevAiLogDir = "$Global:DevAiRoot\logs"

if (-not (Test-Path $Global:DevAiLogDir)) {
    New-Item -ItemType Directory -Path $Global:DevAiLogDir -Force | Out-Null
}

function Write-DevAiLog {
    param(
        [string]$message,
        [string]$category = "general"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logFile = "$Global:DevAiLogDir\$category.log"
    $line = "[$timestamp] $message"

    Add-Content -Path $logFile -Value $line
}

Write-Host "DevAiCoreX logging module loaded." -ForegroundColor Green
