# DevAiCoreX VS Toolchain Helper
# Provides commands for building, compiling, and checking MSVC toolchain.

Write-Host "Loading VS toolchain helper..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function VS-Build {
    param([string]$project)

    if (-not (Test-Path $project)) {
        Write-Host "Project not found: $project" -ForegroundColor Red
        return
    }

    Write-Host "Building project: $project" -ForegroundColor Yellow
    msbuild.exe $project
}

function VS-Check {
    Write-Host "Checking MSVC environment..." -ForegroundColor Cyan

    if ($env:MSVC_BIN) {
        Write-Host "MSVC bin: $env:MSVC_BIN" -ForegroundColor Green
    } else {
        Write-Host "MSVC bin not set." -ForegroundColor Red
    }

    if ($env:MSVC_INCLUDE) {
        Write-Host "MSVC include: $env:MSVC_INCLUDE" -ForegroundColor Green
    }

    if ($env:MSVC_LIB) {
        Write-Host "MSVC lib: $env:MSVC_LIB" -ForegroundColor Green
    }
}

Write-Host "VS toolchain helper ready." -ForegroundColor Green
