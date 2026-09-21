Write-Host "[DEPLOY] Deploying project..."

if (-not (Test-Path "./build")) {
    Write-Host "[DEPLOY] No build found. Run 'devai build' first."
    exit 1
}

Write-Host "[DEPLOY] Packaging build..."

$dest = "./deploy-package"

if (Test-Path $dest) {
    Remove-Item $dest -Recurse -Force
}

Copy-Item "./build" $dest -Recurse -Force

Write-Host "[DEPLOY] Deployment package created at $dest"
