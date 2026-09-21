# DevAiCoreX Security Module
# Provides basic security checks and safe-operation helpers.

Write-Host "Loading DevAiCoreX security module..." -ForegroundColor Cyan

function Check-Admin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($id)

    if ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        Write-Host "Running as Administrator." -ForegroundColor Green
        return $true
    } else {
        Write-Host "Not running as Administrator." -ForegroundColor Yellow
        return $false
    }
}

function Check-ExecutionPolicy {
    $policy = Get-ExecutionPolicy
    Write-Host "Execution Policy: $policy" -ForegroundColor Cyan
}

Check-Admin
Check-ExecutionPolicy

Write-Host "Security module ready." -ForegroundColor Green
