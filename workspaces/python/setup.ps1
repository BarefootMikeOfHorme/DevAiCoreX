Write-Host "[PYTHON SETUP] Creating Python virtual environment..."
python -m venv venv
Write-Host "[PYTHON SETUP] Installing dependencies..."
venv\Scripts\pip install -r requirements.txt
Write-Host "[PYTHON SETUP] Setup complete."
