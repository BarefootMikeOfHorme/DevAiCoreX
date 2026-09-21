# DevAiCoreX Network Module
# Provides basic network diagnostics and connectivity checks.

Write-Host "Loading DevAiCoreX network module..." -ForegroundColor Cyan

function Check-Internet {
    Write-Host "Checking internet connectivity..." -ForegroundColor Yellow
    try {
        $result = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        if ($result) {
            Write-Host "Internet connection OK." -ForegroundColor Green
        } else {
            Write-Host "No internet connection." -ForegroundColor Red
        }
    } catch {
        Write-Host "Network check failed." -ForegroundColor Red
    }
}

function Show-IP {
    Write-Host "IP Configuration:" -ForegroundColor Cyan
    ipconfig
}

Check-Internet
Show-IP

Write-Host "Network module ready." -ForegroundColor Green
