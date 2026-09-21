# DevAiCoreX Creation Guardrails
# Prevents accidental overwrites, deletes, or destructive operations.

Write-Host "Loading creation guardrails..." -ForegroundColor Cyan

function Confirm-Action {
    param([string]$message)

    Write-Host "$message" -ForegroundColor Yellow
    $response = Read-Host "Type YES to continue"

    if ($response -ne "YES") {
        Write-Host "Action cancelled." -ForegroundColor Red
        return $false
    }

    return $true
}

function Safe-Delete {
    param([string]$path)

    if (-not (Test-Path $path)) {
        Write-Host "Cannot delete missing path: $path" -ForegroundColor Red
        return
    }

    if (Confirm-Action "Delete: $path ?") {
        Remove-Item $path -Recurse -Force
        Write-Host "Deleted: $path" -ForegroundColor Green
    }
}

Write-Host "Guardrails module ready." -ForegroundColor Green
