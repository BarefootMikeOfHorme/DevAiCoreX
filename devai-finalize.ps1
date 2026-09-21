# DevAiCoreX Finalization Script (Ultra Version)
# Generates:
#   - Master Index (TXT + JSON)
#   - Dependency Map (TXT + JSON)
#   - Bootstrap Validation (TXT + JSON)
#   - SHA256 Hash Report (TXT + JSON)
#   - Super Report (TXT + JSON)
#   - Color-coded PASS/FAIL banners
#   - Auto-open reports after generation

Write-Host "Finalizing DevAiCoreX installation..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

# ------------------------------------------------------------
# 1. BASIC MODULE PRESENCE CHECK
# ------------------------------------------------------------

$critical = @(
    "environment.ps1","creation-guardrails.ps1","validation.ps1","logging.ps1",
    "routing.ps1","core.ps1","profile-loader.ps1","global-profile.ps1",
    "devshell-aliases.ps1","devai-shell-tools.ps1","devai-shell-profile.ps1",
    "startup-menu.ps1","engine-register.ps1","engine-loader.ps1",
    "workspace-register.ps1","workspace-loader.ps1","ai-context-register.ps1",
    "ai-context-loader.ps1","game-engine-loader.ps1","devai-bootstrap.ps1",
    "devai-run.ps1","devai-build.ps1","devai-test.ps1","devai-deploy.ps1",
    "devai-clean-all.ps1"
)

Write-Host "`nChecking critical modules..." -ForegroundColor Yellow

$validationResults = @()
$allOk = $true

foreach ($m in $critical) {
    $path = "$root\$m"
    if (-not (Test-Path $path)) {
        Write-Host "❌ MISSING: $m" -ForegroundColor Red
        $validationResults += @{ module=$m; status="missing"; size=0 }
        $allOk = $false
        continue
    }

    $info = Get-Item $path
    if ($info.Length -eq 0) {
        Write-Host "⚠ EMPTY: $m" -ForegroundColor Red
        $validationResults += @{ module=$m; status="empty"; size=0 }
        $allOk = $false
    } else {
        Write-Host "✔ OK: $m ($($info.Length) bytes)" -ForegroundColor Green
        $validationResults += @{ module=$m; status="ok"; size=$info.Length }
    }
}

# Save bootstrap validation TXT + JSON
$validationTxt = "$root\bootstrap-validation.txt"
$validationJson = "$root\bootstrap-validation.json"

$validationResults | ForEach-Object {
    "$($_.module) - $($_.status) - $($_.size) bytes"
} | Set-Content $validationTxt

$validationResults | ConvertTo-Json -Depth 5 | Set-Content $validationJson

# ------------------------------------------------------------
# 2. RUN MASTER INDEX (TXT + JSON)
# ------------------------------------------------------------

Write-Host "`nRunning master index generator..." -ForegroundColor Yellow
. "$root\devai-master-index.ps1"

# Convert master index to JSON
$masterIndexTxt = "$root\master-index.txt"
$masterIndexJson = "$root\master-index.json"

$masterIndexJsonObj = @()

Get-Content $masterIndexTxt | ForEach-Object {
    if ($_ -match "^(.*)\s+(\d+)\s+bytes\s+(.*)$") {
        $masterIndexJsonObj += @{
            module = $matches[1]
            size   = $matches[2]
            purpose = $matches[3]
        }
    }
}

$masterIndexJsonObj | ConvertTo-Json -Depth 5 | Set-Content $masterIndexJson

# ------------------------------------------------------------
# 3. RUN DEPENDENCY MAP (TXT + JSON)
# ------------------------------------------------------------

Write-Host "`nRunning dependency map generator..." -ForegroundColor Yellow
. "$root\devai-dependency-map.ps1"

$depTxt = "$root\dependency-map.txt"
$depJson = "$root\dependency-map.json"

$depJsonObj = @{
    loadOrder = @()
    dependencies = @{}
}

$section = ""

Get-Content $depTxt | ForEach-Object {
    if ($_ -match "^Load Order") { $section = "load" }
    elseif ($_ -match "^Dependencies") { $section = "deps" }
    elseif ($section -eq "load" -and $_ -match "^\d+\. (.*)$") {
        $depJsonObj.loadOrder += $matches[1]
    }
    elseif ($section -eq "deps" -and $_ -match "^(.*) -> (.*)$") {
        $depJsonObj.dependencies[$matches[1]] = $matches[2].Split(", ")
    }
}

$depJsonObj | ConvertTo-Json -Depth 5 | Set-Content $depJson

# ------------------------------------------------------------
# 4. RUN HASH REPORT (TXT + JSON)
# ------------------------------------------------------------

Write-Host "`nRunning SHA256 hash report..." -ForegroundColor Yellow
. "$root\devai-hash-report.ps1"

$hashTxt = "$root\hash-report.txt"
$hashJson = "$root\hash-report.json"

$hashJsonObj = @()

Get-Content $hashTxt | ForEach-Object {
    if ($_ -match "^(.*)\s+([A-Fa-f0-9]{64})$") {
        $hashJsonObj += @{
            module = $matches[1]
            sha256 = $matches[2]
        }
    }
}

$hashJsonObj | ConvertTo-Json -Depth 5 | Set-Content $hashJson

# ------------------------------------------------------------
# 5. SUPER REPORT (TXT + JSON)
# ------------------------------------------------------------

Write-Host "`nBuilding SUPER REPORT..." -ForegroundColor Yellow

$superJson = "$root\super-report.json"
$superTxt  = "$root\super-report.txt"

$superObj = @{
    timestamp = (Get-Date)
    bootstrapValidation = $validationResults
    masterIndex = $masterIndexJsonObj
    dependencyMap = $depJsonObj
    hashReport = $hashJsonObj
}

$superObj | ConvertTo-Json -Depth 10 | Set-Content $superJson

# Human-readable TXT
$superLines = @()
$superLines += "DevAiCoreX SUPER REPORT"
$superLines += "Generated: $(Get-Date)"
$superLines += ""
$superLines += "=== Bootstrap Validation ==="
Get-Content $validationTxt | ForEach-Object { $superLines += $_ }
$superLines += ""
$superLines += "=== Master Index ==="
Get-Content $masterIndexTxt | ForEach-Object { $superLines += $_ }
$superLines += ""
$superLines += "=== Dependency Map ==="
Get-Content $depTxt | ForEach-Object { $superLines += $_ }
$superLines += ""
$superLines += "=== Hash Report ==="
Get-Content $hashTxt | ForEach-Object { $superLines += $_ }

$superLines | Set-Content $superTxt

# ------------------------------------------------------------
# 6. COLOR BANNER
# ------------------------------------------------------------

Write-Host "`n----------------------------------------" -ForegroundColor Cyan
if ($allOk) {
    Write-Host "██████████████████████████████████████" -ForegroundColor Green
    Write-Host "        FINALIZATION STATUS: PASS      " -ForegroundColor Green
    Write-Host "██████████████████████████████████████" -ForegroundColor Green
} else {
    Write-Host "██████████████████████████████████████" -ForegroundColor Red
    Write-Host "        FINALIZATION STATUS: FAIL      " -ForegroundColor Red
    Write-Host "██████████████████████████████████████" -ForegroundColor Red
}
Write-Host "----------------------------------------" -ForegroundColor Cyan

# ------------------------------------------------------------
# 7. AUTO-OPEN REPORTS
# ------------------------------------------------------------

Write-Host "`nOpening reports..." -ForegroundColor Yellow

Start-Process $validationTxt
Start-Process $masterIndexTxt
Start-Process $depTxt
Start-Process $hashTxt
Start-Process $superTxt
Start-Process $superJson

Write-Host "`nAll reports opened." -ForegroundColor Green
Write-Host "DevAiCoreX Finalization Complete." -ForegroundColor Cyan
