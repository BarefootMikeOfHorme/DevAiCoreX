# DevAiCoreX - Manifest Generator & Schema Validator
# Stage-5 Schema Pass - Enhanced Version
# Generates manifest.jsonc, manifest.yamlc, manifest.cbor
# Scans: core configs, workspace metadata, template metadata,
#        creation-station metadata, module metadata

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

Write-Host "`n=== DevAiCoreX Manifest Generator ===`n" -ForegroundColor Cyan

# --- Helper: Build a manifest entry object ---
function New-ManifestEntry {
    param(
        [string]$Kind,
        [string]$Name,
        [string]$ParentPath
    )

    return [PSCustomObject]@{
        kind       = $Kind
        name       = $Name
        parentPath = $ParentPath
        yamlc      = (Test-Path "$ParentPath.yamlc")
        jsonc      = (Test-Path "$ParentPath.jsonc")
        cbor       = (Test-Path "$ParentPath.cbor")
    }
}

# --- Collect manifest entries ---
$entries = @()

Write-Host "Scanning core configs..." -ForegroundColor Yellow
$entries += New-ManifestEntry "engine"        "engine"        "$Root\engine"
$entries += New-ManifestEntry "workspace"     "workspace"     "$Root\workspace"
$entries += New-ManifestEntry "ai-context"    "ai-context"    "$Root\ai-context"
$entries += New-ManifestEntry "game-engine"   "game-engine"   "$Root\game-engine"
$entries += New-ManifestEntry "project"       "devai-project" "$Root\devai-project"

Write-Host "Scanning workspace metadata..." -ForegroundColor Yellow
Get-ChildItem "$Root\workspaces" -Recurse -Filter "metadata.yaml" -ErrorAction SilentlyContinue |
    ForEach-Object {
        $base = $_.FullName.Replace(".yaml","")
        $name = Split-Path (Split-Path $_.FullName -Parent) -Leaf
        $entries += New-ManifestEntry "workspace-metadata" $name $base
    }

Write-Host "Scanning template metadata..." -ForegroundColor Yellow
Get-ChildItem "$Root\templates" -Recurse -Filter "metadata.yaml" -ErrorAction SilentlyContinue |
    ForEach-Object {
        $base = $_.FullName.Replace(".yaml","")
        $name = Split-Path (Split-Path $_.FullName -Parent) -Leaf
        $entries += New-ManifestEntry "template-metadata" $name $base
    }

Write-Host "Scanning creation-station metadata..." -ForegroundColor Yellow
Get-ChildItem "$Root\creation-station" -Recurse -Filter "metadata.yaml" -ErrorAction SilentlyContinue |
    ForEach-Object {
        $base = $_.FullName.Replace(".yaml","")
        $name = Split-Path (Split-Path $_.FullName -Parent) -Leaf
        $entries += New-ManifestEntry "cs-metadata" $name $base
    }

Write-Host "Scanning module metadata..." -ForegroundColor Yellow
Get-ChildItem "$Root\modules" -Recurse -Filter "metadata.yaml" -ErrorAction SilentlyContinue |
    ForEach-Object {
        $base = $_.FullName.Replace(".yaml","")
        $name = Split-Path (Split-Path $_.FullName -Parent) -Leaf
        $entries += New-ManifestEntry "module-metadata" $name $base
    }

Write-Host "`nCollected $($entries.Count) manifest entries.`n" -ForegroundColor Green

# --- Validate schema presence ---
foreach ($e in $entries) {
    if (-not $e.yamlc) { Write-Host "[WARN] Missing YAML-C for $($e.kind): $($e.name)" -ForegroundColor DarkYellow }
    if (-not $e.jsonc) { Write-Host "[WARN] Missing JSONC for $($e.kind): $($e.name)" -ForegroundColor DarkYellow }
    if (-not $e.cbor)  { Write-Host "[WARN] Missing CBOR for $($e.kind): $($e.name)"  -ForegroundColor DarkYellow }
}

# --- Build manifest object ---
$manifestObject = [PSCustomObject]@{
    version = "1.0.0"
    updated = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
    entries = $entries
}

# --- Write manifest.jsonc ---
$manifestJsonPath = "$Root\manifest.jsonc"
$manifestObject | ConvertTo-Json -Depth 6 | Set-Content $manifestJsonPath
Write-Host "Wrote manifest.jsonc" -ForegroundColor Green

# --- Write manifest.yamlc ---
$manifestYamlPath = "$Root\manifest.yamlc"
$yamlLines = @()
$yamlLines += "manifest:"
$yamlLines += "  version: $($manifestObject.version)"
$yamlLines += "  updated: $($manifestObject.updated)"
$yamlLines += "  entries:"

foreach ($e in $entries) {
    $yamlLines += "    - kind: $($e.kind)"
    $yamlLines += "      name: $($e.name)"
    $yamlLines += "      parentPath: $($e.parentPath)"
    $yamlLines += "      yamlc: $($e.yamlc)"
    $yamlLines += "      jsonc: $($e.jsonc)"
    $yamlLines += "      cbor: $($e.cbor)"
}

$yamlLines | Set-Content $manifestYamlPath
Write-Host "Wrote manifest.yamlc" -ForegroundColor Green

# --- Write manifest.cbor (placeholder) ---
" d9d9f7a3646d616e69666573746f626a656374 " | Set-Content "$Root\manifest.cbor"
Write-Host "Wrote manifest.cbor (placeholder)" -ForegroundColor Green

Write-Host "`nManifest generation complete.`n" -ForegroundColor Cyan
