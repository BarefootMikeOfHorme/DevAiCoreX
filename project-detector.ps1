# DevAiCoreX Project Detector
# Detects current project/workspace based on directory structure and known markers.

Write-Host "Detecting DevAiCoreX project..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$currentPath = (Get-Location).Path

Write-Host "Current path: $currentPath" -ForegroundColor Yellow

# Known workspace root
$workspaceRoot = "$Global:DevAiRoot\workspaces"

if (-not (Test-Path $workspaceRoot)) {
    Write-Host "Workspace root missing: $workspaceRoot" -ForegroundColor Red
    return
}

# Try to match current path to a workspace
$matchedWorkspace = $null
$workspaceFolders = Get-ChildItem $workspaceRoot -Directory

foreach ($ws in $workspaceFolders) {
    if ($currentPath -like "$($ws.FullName)*") {
        $matchedWorkspace = $ws
        break
    }
}

if ($matchedWorkspace) {
    Write-Host "Matched workspace: $($matchedWorkspace.Name)" -ForegroundColor Green
    $Global:DevAiWorkspace = $matchedWorkspace.FullName
} else {
    Write-Host "No matching workspace found for current path." -ForegroundColor Yellow
}

# Detect project markers (e.g., .git, pyproject.toml, CMakeLists.txt)
$markers = @(".git", "pyproject.toml", "CMakeLists.txt", "package.json")

$foundMarkers = @()
foreach ($marker in $markers) {
    $markerPath = Join-Path $currentPath $marker
    if (Test-Path $markerPath) {
        $foundMarkers += $marker
    }
}

if ($foundMarkers.Count -gt 0) {
    Write-Host "Detected project markers:" -ForegroundColor Cyan
    foreach ($m in $foundMarkers) {
        Write-Host " - $m" -ForegroundColor Green
    }
} else {
    Write-Host "No known project markers detected." -ForegroundColor Yellow
}

Write-Host "Project detection complete." -ForegroundColor Green
