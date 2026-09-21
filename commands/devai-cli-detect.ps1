Write-Host "[DETECT] Detecting DevAiCoreX project environment..."

$context = @{
    engine     = (Test-Path "./engine.yaml")
    workspace  = (Test-Path "./workspace.yaml")
    aiContext  = (Test-Path "./ai-context.yaml")
    gameEngine = (Test-Path "./game-engine.yaml")
    project    = (Test-Path "./devai-project.yaml")
}

foreach ($key in $context.Keys) {
    Write-Host ("[DETECT] {0,-12}: {1}" -f $key, $context[$key])
}

Write-Host "[DETECT] Detection complete."
