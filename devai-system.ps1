# DevAiCoreX System Module
# Provides system information and hardware summaries.

Write-Host "Loading DevAiCoreX system module..." -ForegroundColor Cyan

function Show-SystemInfo {
    Write-Host "System Information:" -ForegroundColor Yellow
    Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, CsProcessors, CsTotalPhysicalMemory
}

function Show-Disks {
    Write-Host "Disk Information:" -ForegroundColor Cyan
    Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
}

Show-SystemInfo
Show-Disks

Write-Host "System module ready." -ForegroundColor Green
