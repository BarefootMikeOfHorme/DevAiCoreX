# DevAiCoreX Update Module
# Performs framework updates and version bumps.

Write-Host "DevAiCoreX Update Module" -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Update-DevAiCoreX {
    Write-Host "Checking for updates..." -ForegroundColor Yellow

    # Placeholder for future GitHub integration
    Write-Host "No remote update source configured." -ForegroundColor Red

    Write-Host "Local update complete." -ForegroundColor Green
}

function Bump-Version {
    param([string]$type)

    $versionFile = "$Global:DevAiRoot\version.txt"
    $ver = Get-Content $versionFile -Raw
    $parts = $ver.Split(".")

    switch ($type) {
        "major" { $parts[0] = [int]$parts[0] + 1; $parts[1] = 0; $parts[2] = 0 }
        "minor" { $parts[1] = [int]$parts[1] + 1; $parts[2] = 0 }
        "patch" { $parts[2] = [int]$parts[2] + 1 }
        default { Write-Host "Invalid bump type." -ForegroundColor Red; return }
    }

    $newVer = "$($parts[0]).$($parts[1]).$($parts[2])"
    $newVer | Set-Content $versionFile

    Write-Host "Version bumped to: $newVer" -ForegroundColor Green
}

Write-Host "Update module ready." -ForegroundColor Green
