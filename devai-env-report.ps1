# DevAiCoreX Environment Report
# Summarizes environment variables, paths, and core system info.

Write-Host "Generating DevAiCoreX environment report..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

Write-Host "Root: $Global:DevAiRoot" -ForegroundColor Green
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow

Write-Host "`nEnvironment Variables:" -ForegroundColor Cyan
Get-ChildItem Env: | Sort-Object Name | Format-Table -AutoSize

Write-Host "`nPATH Entries:" -ForegroundColor Cyan
$env:PATH -split ";" | Format-Table -AutoSize

Write-Host "`nEnvironment report complete." -ForegroundColor Green
