# DevAiCoreX CBOR Build Script
# Converts: YAML-C → YAML → JSON → JSONC → JSON → CBOR

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

Write-Host "`n=== DevAiCoreX CBOR Build Script ===`n" -ForegroundColor Cyan

$manifestPath = "$Root\manifest.jsonc"
$manifestRaw = Get-Content $manifestPath -Raw
$manifestClean = ($manifestRaw -split "`n" | ForEach-Object {
    if ($_.Trim().StartsWith("//")) { return $null }
    return ($_ -replace "//.*","")
}) -join "`n"
$manifest = $manifestClean | ConvertFrom-Json

function Strip-JsoncComments {
    param([string]$jsonc)
    $lines = $jsonc -split "`n"
    $clean = @()
    foreach ($line in $lines) {
        if ($line.Trim().StartsWith("//")) { continue }
        $clean += ($line -replace "//.*","")
    }
    return ($clean -join "`n")
}

function Normalize-YamlC {
    param([string]$path)
    $raw = Get-Content $path -Raw
    $lines = $raw -split "`n"
    $clean = @()
    foreach ($line in $lines) {
        if ($line.Trim().StartsWith("#")) { continue }
        $clean += $line
    }
    return ($clean -join "`n")
}

function Convert-Yaml-To-Json {
    param([string]$yamlText)
    try {
        $yamlObj = ConvertFrom-Yaml $yamlText
        return ($yamlObj | ConvertTo-Json -Depth 20)
    } catch {
        Write-Host "[ERROR] YAML → JSON conversion failed." -ForegroundColor Red
        return $null
    }
}

function Convert-Json-To-Jsonc {
    param([string]$jsonText, [string]$moduleName)
    $jsonLines = $jsonText -split "`n"
    $jsonc = @("// JSONC generated for module: $moduleName")
    $jsonc += $jsonLines
    return ($jsonc -join "`n")
}

function Convert-Json-To-CborHex {
    param([string]$jsonText)
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($jsonText)
        $cbor = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes)
        return ($cbor | ForEach-Object { $_.ToString("x2") }) -join ""
    } catch {
        Write-Host "[ERROR] JSON → CBOR encoding failed." -ForegroundColor Red
        return $null
    }
}

foreach ($entry in $manifest.entries) {

    $baseName = $entry.name

    $yamlCPath  = "$Root\$baseName.yamlc"
    $yamlPath   = "$Root\$baseName.yaml"
    $jsonPath   = "$Root\$baseName.json"
    $jsoncPath  = "$Root\$baseName.jsonc"
    $cborPath   = "$Root\$baseName.cbor"

    Write-Host "`nProcessing module: $baseName" -ForegroundColor Yellow

    if (!(Test-Path $yamlCPath)) { Write-Host "[WARN] YAML-C missing for $baseName"; continue }

    $yamlClean = Normalize-YamlC -path $yamlCPath
    $yamlClean | Set-Content $yamlPath
    Write-Host " - YAML-C normalized."

    $jsonPure = Convert-Yaml-To-Json -yamlText $yamlClean
    if ($jsonPure -eq $null) { Write-Host "[FATAL] JSON conversion failed for $baseName"; continue }
    $jsonPure | Set-Content $jsonPath
    Write-Host " - YAML → JSON complete."

    $jsonc = Convert-Json-To-Jsonc -jsonText $jsonPure -moduleName $baseName
    $jsonc | Set-Content $jsoncPath
    Write-Host " - JSONC generated."

    $jsonStripped = Strip-JsoncComments -jsonc $jsonc
    Write-Host " - JSONC comments stripped."

    $cborHex = Convert-Json-To-CborHex -jsonText $jsonStripped
    if ($cborHex -eq $null) { Write-Host "[FATAL] CBOR encoding failed for $baseName"; continue }
    $cborHex | Set-Content $cborPath
    Write-Host " - CBOR written."

    if ($entry.PSObject.Properties.Name -contains "updated") {
        $entry.updated = (Get-Date).ToString("o")
    }
}

$manifest | ConvertTo-Json -Depth 20 | Set-Content $manifestPath
Write-Host "`nCBOR build complete. Manifest updated." -ForegroundColor Cyan
