# DevAiCoreX Cleanup Utility
# Removes temp files, logs, caches, and stale backups.

Write-Host "Running DevAiCoreX cleanup..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

$targets = @(
    "$Global:DevAiRoot\logs",
    "$Global:DevAiRoot\temp",
    "$Global:DevAiRoot\cache"
)

foreach ($t in $targets) {
    if (Test-Path $t) {
        Write-Host "Cleaning: $t" -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force
        New-Item -ItemType Directory -Path $t | Out-Null
        Write-Host "Reset: $t" -ForegroundColor Green
    }
}

Write-Host "Cleanup complete." -ForegroundColor Green
