Write-Host "[CREATE] Creation Station activated."

param(
    [string]$Target,
    [string]$Name
)

if (-not $Target) {
    Write-Host "Usage: devai create <engine|workspace|ai|game|project> <name>"
    exit 1
}

if (-not $Name) {
    Write-Host "[CREATE] Missing name parameter."
    exit 1
}

Write-Host "[CREATE] Generating new $Target: $Name"

$base = "./$Target-$Name"

if (-not (Test-Path $base)) {
    New-Item -ItemType Directory -Path $base -Force | Out-Null
}

New-Item -ItemType File -Path "$base/metadata.yaml" -Force | Out-Null
New-Item -ItemType File -Path "$base/template.txt" -Force | Out-Null

Write-Host "[CREATE] $Target '$Name' created successfully."
