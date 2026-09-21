# DevAiCoreX AI Context Loader
# Automatically loads all AI context modules found in the ai-context directory.

Write-Host "Loading DevAiCoreX AI contexts..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"
$aiRoot = "$Global:DevAiRoot\ai-context"

# Verify AI context directory exists
if (-not (Test-Path $aiRoot)) {
    Write-Host "AI context directory missing: $aiRoot" -ForegroundColor Red
    return
}

Write-Host "AI context directory found." -ForegroundColor Green

# Detect AI context folders
$aiFolders = Get-ChildItem $aiRoot -Directory

if ($aiFolders.Count -eq 0) {
    Write-Host "No AI contexts detected." -ForegroundColor Yellow
} else {
    Write-Host "Detected AI contexts:" -ForegroundColor Cyan
    foreach ($folder in $aiFolders) {
        Write-Host " - $($folder.Name)" -ForegroundColor Yellow
    }
}

# Load each AI context's bootstrap script
foreach ($folder in $aiFolders) {
    $bootstrap = "$($folder.FullName)\bootstrap.ps1"

    if (Test-Path $bootstrap) {
        Write-Host "Loading AI context bootstrap: $($folder.Name)" -ForegroundColor Yellow
        try {
            . $bootstrap
            Write-Host "AI context loaded: $($folder.Name)" -ForegroundColor Green
        }
        catch {
            Write-Host "AI context failed to load: $($folder.Name)" -ForegroundColor Red
        }
    } else {
        Write-Host "Missing bootstrap.ps1 for AI context: $($folder.Name)" -ForegroundColor Red
    }
}

Write-Host "AI context loading complete." -ForegroundColor Green
