Write-Host "[INIT] Initializing DevAiCoreX project..."

if (Test-Path "./devai-project.yaml") {
    Write-Host "[INIT] Project already initialized."
    exit 1
}

@"
project: devai
created: $(Get-Date)
"@ | Set-Content "./devai-project.yaml"

Write-Host "[INIT] Project initialized successfully."
