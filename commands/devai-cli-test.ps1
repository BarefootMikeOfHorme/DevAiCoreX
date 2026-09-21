Write-Host "[TEST] Running project tests..."

$testDir = "./tests"

if (-not (Test-Path $testDir)) {
    Write-Host "[TEST] No tests directory found."
    exit 1
}

$tests = Get-ChildItem $testDir -Filter "*.ps1"

if ($tests.Count -eq 0) {
    Write-Host "[TEST] No test scripts found."
    exit 1
}

foreach ($t in $tests) {
    Write-Host "[TEST] Executing $($t.Name)..."
    & $t.FullName
}

Write-Host "[TEST] All tests executed."
