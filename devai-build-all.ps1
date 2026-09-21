# DevAiCoreX Unified Build Chain
# Runs manifest generation, repairs, CBOR build, and guardrails

Write-Host "`n=== DevAiCoreX Unified Build Chain ===`n" -ForegroundColor Cyan

Write-Host "Step 1: Manifest Generation" -ForegroundColor Yellow
& "$PSScriptRoot\devai-cli-manifest.ps1"

Write-Host "Step 2: Normalize parentPath" -ForegroundColor Yellow
& "$PSScriptRoot\devai-manifest-repair.ps1"

Write-Host "Step 3: Add updated field" -ForegroundColor Yellow
& "$PSScriptRoot\devai-manifest-add-updated.ps1"

Write-Host "Step 4: Add version field" -ForegroundColor Yellow
& "$PSScriptRoot\devai-manifest-add-version.ps1"

Write-Host "Step 5: CBOR Build" -ForegroundColor Yellow
& "$PSScriptRoot\devai-cbor-build.ps1"

Write-Host "Step 6: Guardrail Enforcement" -ForegroundColor Yellow
& "$PSScriptRoot\guardrails.ps1"

Write-Host "`n=== DevAiCoreX Build Complete ===`n" -ForegroundColor Green
