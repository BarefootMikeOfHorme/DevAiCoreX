Write-Host "[VALIDATE] Validating DevAiCoreX project integrity..."

$required = @(
    "devai-project.yaml",
    "engine.yaml",
    "workspace.yaml",
    "ai-context.yaml",
    "game-engine.yaml"
)

$missing = @()

foreach ($file in $required) {
    if (-not (Test-Path "./$file")) {
        $missing += $file
    }
}

if ($missing.Count -gt 0) {
    Write-Host "[VALIDATE] Missing required files:"
    $missing | ForEach-Object { Write-Host " - $_" }
    Write-Host "[VALIDATE] Validation failed."
    exit 1
}

Write-Host "[VALIDATE] All required files present."
Write-Host "[VALIDATE] Project structure validated successfully."
