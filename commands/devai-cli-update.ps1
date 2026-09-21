Write-Host "[UPDATE] Updating DevAiCoreX modules..."

$modules = @(
    "./engine.yaml",
    "./workspace.yaml",
    "./ai-context.yaml",
    "./game-engine.yaml"
)

foreach ($m in $modules) {
    if (Test-Path $m) {
        Write-Host "[UPDATE] Refreshing metadata: $m"
        $content = Get-Content $m -Raw
        $normalized = $content.Trim()
        $normalized | Set-Content $m
    } else {
        Write-Host "[UPDATE] Skipping missing module: $m"
    }
}

Write-Host "[UPDATE] Update complete."
