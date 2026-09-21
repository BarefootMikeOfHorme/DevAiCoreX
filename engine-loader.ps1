# DevAiCoreX Engine Loader
# Automatically loads all engine modules found in the engines directory.

Write-Host "Loading DevAiCoreX engines..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$engineRoot = "$Global:DevAiRoot\engines"

# Verify engine directory exists
if (-not (Test-Path $engineRoot)) {
    Write-Host "Engine directory missing: $engineRoot" -ForegroundColor Red
    return
}

Write-Host "Engine directory found." -ForegroundColor Green

# Detect engine folders
$engineFolders = Get-ChildItem $engineRoot -Directory

if ($engineFolders.Count -eq 0) {
    Write-Host "No engines detected." -ForegroundColor Yellow
} else {
    Write-Host "Detected engines:" -ForegroundColor Cyan
    foreach ($folder in $engineFolders) {
        Write-Host " - $($folder.Name)" -ForegroundColor Yellow
    }
}

# Load each engine's bootstrap script
foreach ($folder in $engineFolders) {
    $bootstrap = "$($folder.FullName)\bootstrap.ps1"

    if (Test-Path $bootstrap) {
        Write-Host "Loading engine bootstrap: $($folder.Name)" -ForegroundColor Yellow
        try {
            . $bootstrap
            Write-Host "Engine loaded: $($folder.Name)" -ForegroundColor Green
        }
        catch {
            Write-Host "Engine failed to load: $($folder.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "Missing bootstrap.ps1 for engine: $($folder.Name)" -ForegroundColor Red
    }
}

Write-Host "Engine loading complete." -ForegroundColor Green
