Write-Host "[RUN] Executing project..."

if (-not (Test-Path "./build")) {
    Write-Host "[RUN] No build found. Run 'devai build' first."
    exit 1
}

$exe = "./build/main.exe"

if (-not (Test-Path $exe)) {
    Write-Host "[RUN] No main executable found at $exe"
    exit 1
}

Write-Host "[RUN] Launching runtime..."
Start-Process $exe

Write-Host "[RUN] Runtime started."
