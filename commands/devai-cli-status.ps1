Write-Host "[STATUS] DevAiCoreX Environment Status"
Write-Host "--------------------------------------"

$items = @{
    "Engine"      = (Test-Path "./engine.yaml")
    "Workspace"   = (Test-Path "./workspace.yaml")
    "AI Context"  = (Test-Path "./ai-context.yaml")
    "Game Engine" = (Test-Path "./game-engine.yaml")
    "Project"     = (Test-Path "./devai-project.yaml")
}

foreach ($key in $items.Keys) {
    Write-Host ("{0,-12}: {1}" -f $key, $items[$key])
}

Write-Host "--------------------------------------"
Write-Host "[STATUS] Complete."
