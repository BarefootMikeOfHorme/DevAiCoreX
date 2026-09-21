Write-Host "[BACKUP] Creating DevAiCoreX project backup..."

$backupDir = "./backup"

if (-not (Test-Path $backupDir)) {
    Write-Host "[BACKUP] Creating backup directory..."
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

$items = @(
    "devai-project.yaml",
    "engine.yaml",
    "workspace.yaml",
    "ai-context.yaml",
    "game-engine.yaml"
)

foreach ($item in $items) {
    $src = "./$item"
    if (Test-Path $src) {
        Copy-Item $src $backupDir -Force
        Write-Host " - Backed up $item"
    } else {
        Write-Host " - Skipped missing file: $item"
    }
}

Write-Host "[BACKUP] Backup complete."
