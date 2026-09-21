Write-Host "[INSPECT] Inspecting DevAiCoreX environment..."

$files = @(
    "engine.yaml",
    "workspace.yaml",
    "ai-context.yaml",
    "game-engine.yaml",
    "devai-project.yaml"
)

foreach ($f in $files) {
    $path = "./$f"
    if (Test-Path $path) {
        Write-Host (" - {0,-18} FOUND" -f $f)
    } else {
        Write-Host (" - {0,-18} MISSING" -f $f)
    }
}

Write-Host "[INSPECT] Inspection complete."
