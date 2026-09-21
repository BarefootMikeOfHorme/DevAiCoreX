# DevAiCoreX Game Engine Cleanup Helper
# Cleans game engine temp, cache, and build artifacts.

Write-Host "Cleaning game engine artifacts..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Clean-GameEngine {
    param([string]$engine)

    $enginePath = "$Global:DevAiRoot\game-engines\$engine"
    $targets = @("temp", "cache", "build")

    if (-not (Test-Path $enginePath)) {
        Write-Host "Game engine not found: $engine" -ForegroundColor Red
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

    Write-Host "Game engine cleanup complete: $engine" -ForegroundColor Green
}

Write-Host "Game engine cleanup helper ready." -ForegroundColor Green
