Write-Host "[PYTHON LINT] Running Python lint checks..."
flake8 .
black --check .
Write-Host "[PYTHON LINT] Linting complete."
