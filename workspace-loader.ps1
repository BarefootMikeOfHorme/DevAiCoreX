# DevAiCoreX Workspace Loader
# Automatically loads all workspace modules found in the workspaces directory.

Write-Host "Loading DevAiCoreX workspaces..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$workspaceRoot = "$Global:DevAiRoot\workspaces"

# Verify workspace directory exists
if (-not (Test-Path $workspaceRoot)) {
    Write-Host "Workspace directory missing: $workspaceRoot" -ForegroundColor Red
    return
}

Write-Host "Workspace directory found." -ForegroundColor Green

# Detect workspace folders
$workspaceFolders = Get-ChildItem $workspaceRoot -Directory

if ($workspaceFolders.Count -eq 0) {
    Write-Host "No workspaces detected." -ForegroundColor Yellow
} else {
    Write-Host "Detected workspaces:" -ForegroundColor Cyan
    foreach ($folder in $workspaceFolders) {
        Write-Host " - $($folder.Name)" -ForegroundColor Yellow
    }
}

# Load each workspace's bootstrap script
foreach ($folder in $workspaceFolders) {
    $bootstrap = "$($folder.FullName)\bootstrap.ps1"

    if (Test-Path $bootstrap) {
        Write-Host "Loading workspace bootstrap: $($folder.Name)" -ForegroundColor Yellow
        try {
            . $bootstrap
            Write-Host "Workspace loaded: $($folder.Name)" -ForegroundColor Green
        }
        catch {
            Write-Host "Workspace failed to load: $($folder.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "Missing bootstrap.ps1 for workspace: $($folder.Name)" -ForegroundColor Red
    }
}

Write-Host "Workspace loading complete." -ForegroundColor Green
