# DevAiCoreX Config Inspector
# Scans all config.json files across engines, workspaces, AI contexts, and game engines.

Write-Host "Inspecting DevAiCoreX configuration files..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

$targets = @(
    "$root\engines",
    "$root\workspaces",
    "$root\ai-context",
    "$root\game-engines"
)

foreach ($t in $targets) {
    if (-not (Test-Path $t)) {
        Write-Host "Missing directory: $t" -ForegroundColor Red
        continue
    }

    Write-Host "`nScanning: $t" -ForegroundColor Yellow

    $folders = Get-ChildItem $t -Directory
    foreach ($f in $folders) {
        $config = Join-Path $f.FullName "config.json"
        if (Test-Path $config) {
            Write-Host " - OK: $($f.Name)/config.json" -ForegroundColor Green
        } else {
            Write-Host " - MISSING: $($f.Name)/config.json" -ForegroundColor Red
        }
    }
}

Write-Host "`nConfig inspection complete." -ForegroundColor Green
