Write-Host "[MULTI DEBUG] Starting multi-language debug session..."
Write-Host "[MULTI DEBUG] Python debug:"
venv\Scripts\python -m pdb main.py
Write-Host "[MULTI DEBUG] Node debug:"
node --inspect main.js
Write-Host "[MULTI DEBUG] Debug session complete."
