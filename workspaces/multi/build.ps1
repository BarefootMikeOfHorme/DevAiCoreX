Write-Host "[MULTI BUILD] Building multi-language workspace..."
venv\Scripts\python setup.py build
npm run build
Write-Host "[MULTI BUILD] Build complete."
