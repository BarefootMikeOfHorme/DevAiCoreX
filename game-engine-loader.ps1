# DevAiCoreX Game Engine Loader
# Automatically loads all game engine modules found in the game-engines directory.

Write-Host "Loading DevAiCoreX game engines..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$gameEngineRoot = "$Global:DevAiRoot\game-engines"

# Verify game engine directory exists
if (-not (Test-Path $gameEngineRoot)) {
    Write-Host "Game engine directory missing: $gameEngineRoot" -ForegroundColor Red
    return
}

Write-Host "Game engine directory found." -ForegroundColor Green

# Detect game engine folders
$engineFolders = Get-ChildItem $gameEngineRoot -Directory

if ($engineFolders.Count -eq 0) {
    Write-Host "No game engines detected." -ForegroundColor Yellow
} else {
    Write-Host "Detected game engines:" -ForegroundColor Cyan
    foreach ($folder in $engineFolders) {
        Write-Host " - $($folder.Name)" -ForegroundColor Yellow
    }
}

# Load each game engine's bootstrap script
foreach ($folder in $engineFolders) {
    $bootstrap = "$($folder.FullName)\bootstrap.ps1"

    if (Test-Path $bootstrap) {
        Write-Host "Loading game engine bootstrap: $($folder.Name)" -ForegroundColor Yellow
        try {
            . $bootstrap
            Write-Host "Game engine loaded: $($folder.Name)" -ForegroundColor Green
        }
        catch {
            Write-Host "Game engine failed to load: $($folder.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "Missing bootstrap.ps1 for game engine: $($folder.Name)" -ForegroundColor Red
    }
}

Write-Host "Game engine loading complete." -ForegroundColor Green
