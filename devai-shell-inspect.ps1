# DevAiCoreX Shell Inspector
# Shows details about the current shell session.

Write-Host "Inspecting current shell..." -ForegroundColor Cyan

Write-Host "Shell: PowerShell" -ForegroundColor Yellow
Write-Host "Version: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow
Write-Host "Execution Policy: $(Get-ExecutionPolicy)" -ForegroundColor Yellow
Write-Host "User: $env:USERNAME" -ForegroundColor Yellow
Write-Host "Machine: $env:COMPUTERNAME" -ForegroundColor Yellow

Write-Host "`nLoaded Modules:" -ForegroundColor Cyan
Get-Module | Select-Object Name, Version | Format-Table -AutoSize

Write-Host "`nShell inspection complete." -ForegroundColor Green
