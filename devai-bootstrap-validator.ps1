# DevAiCoreX Bootstrap Validator
# Validates presence and non-emptiness of all critical modules.

Write-Host "Running DevAiCoreX bootstrap validator..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"
$reportFile = "$root\bootstrap-validation.txt"

$critical = @(
    "environment.ps1",
    "creation-guardrails.ps1",
    "validation.ps1",
    "logging.ps1",
    "routing.ps1",
    "core.ps1",
    "profile-loader.ps1",
    "global-profile.ps1",
    "devshell-aliases.ps1",
    "devai-shell-tools.ps1",
    "devai-shell-profile.ps1",
    "startup-menu.ps1",
    "engine-register.ps1",
    "engine-loader.ps1",
    "workspace-register.ps1",
    "workspace-loader.ps1",
    "ai-context-register.ps1",
    "ai-context-loader.ps1",
    "game-engine-loader.ps1",
    "devai-bootstrap.ps1",
    "devai-run.ps1",
    "devai-build.ps1",
    "devai-test.ps1",
    "devai-deploy.ps1",
    "devai-clean-all.ps1",
    "devai-summary.ps1",
    "devai-finalize.ps1"
)

$lines = @()
$lines += "DevAiCoreX Bootstrap Validation"
$lines += "Generated: $(Get-Date)"
$lines += ""

$allOk = $true

foreach ($m in $critical) {
    $path = Join-Path $root $m
    if (-not (Test-Path $path)) {
        $lines += "MISSING: $m"
        Write-Host "MISSING: $m" -ForegroundColor Red
        $allOk = $false
        continue
    }

    $info = Get-Item $path
    if ($info.Length -eq 0) {
        $lines += "EMPTY: $m"
        Write-Host "EMPTY: $m" -ForegroundColor Red
        $allOk = $false
    } else {
        $lines += "OK: $m ($($info.Length) bytes)"
        Write-Host "OK: $m" -ForegroundColor Green
    }
}

$lines += ""
$lines += "Overall status: " + ($(if ($allOk) { "PASS" } else { "FAIL" }))

$lines | Set-Content $reportFile

Write-Host "Bootstrap validation report written to: $reportFile" -ForegroundColor Green
