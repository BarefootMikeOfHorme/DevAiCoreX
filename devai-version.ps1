# DevAiCoreX Version Module
# Stores and reports the current framework version.

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$versionFile = "$Global:DevAiRoot\version.txt"

if (-not (Test-Path $versionFile)) {
    "1.0.0" | Set-Content $versionFile
}

function Get-DevAiVersion {
    $ver = Get-Content $versionFile -Raw
    Write-Host "DevAiCoreX Version: $ver" -ForegroundColor Cyan
}

function Set-DevAiVersion {
    param([string]$newVersion)
    $newVersion | Set-Content $versionFile
    Write-Host "Version updated to: $newVersion" -ForegroundColor Green
}

Write-Host "Version module loaded." -ForegroundColor Green
