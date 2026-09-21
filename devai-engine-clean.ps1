# DevAiCoreX Engine Cleanup Helper
# Cleans engine temp, cache, and build artifacts.

Write-Host "Cleaning engine artifacts..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Clean-Engine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\engines\$engine"
    $targets = @("temp", "cache", "build")

    if (-not (Test-Path $enginePath)) {
        Write-Host "Engine not found: $engine" -ForegroundColor Red
        return
    }

    foreach ($t in $targets) {
        $p = "$enginePath\$t"
        if (Test-Path $p) {
            Write-Host "Cleaning: $p" -ForegroundColor Yellow
            Remove-Item $p -Recurse -Force
            New-Item -ItemType Directory -Path $p | Out-Null
        }
    }

    Write-Host "Engine cleanup complete: $engine" -ForegroundColor Green
}

Write-Host "Engine cleanup helper ready." -ForegroundColor Green
