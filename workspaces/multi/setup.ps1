Write-Host "[MULTI SETUP] Preparing multi-language workspace..."
python -m venv venv
venv\Scripts\pip install -r requirements.txt
npm install
Write-Host "[MULTI SETUP] Setup complete."
