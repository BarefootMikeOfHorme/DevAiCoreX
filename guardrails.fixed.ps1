# ============================================
# DevAiCoreX - Stage-8 Guardrail Engine (Enforcement, Hybrid Mode)
# File: guardrails.ps1
# ============================================

param(
    [string]$Root = "C:\Users\Administrator\Desktop\DevAiCoreX"
)

Write-Host "`n=== DevAiCoreX Guardrail Engine (Stage-8, Enforcement) ===`n" -ForegroundColor Cyan

# Paths
$guardYaml    = "$Root\guardrails.yamlc"
$guardJson    = "$Root\guardrails.jsonc"
$profilesYaml = "$Root\guardrail-profiles.yamlc"
$hooksPs1     = "$Root\guardrail-hooks.ps1"
$manifestPath = "$Root\manifest.jsonc"
$reportPath   = "$Root\guardrail-report.jsonc"
$handoffPath  = "$Root\handoff.jsonc"

# Basic existence checks
if (!(Test-Path $guardYaml) -or !(Test-Path $guardJson)) {
    Write-Host "[FATAL] Guardrail definitions missing." -ForegroundColor Red
    exit 1
}

if (!(Test-Path $manifestPath)) {
    Write-Host "[FATAL] Manifest missing." -ForegroundColor Red
    exit 1
}

# Load guardrails JSON
$guard = Get-Content $guardJson | ConvertFrom-Json

# Load hooks if present
if (Test-Path $hooksPs1) {
    . $hooksPs1
} else {
    Write-Host "[WARN] guardrail-hooks.ps1 not found; hooks will be skipped." -ForegroundColor DarkYellow
}

# Determine active profile
$activeProfile = $guard.guardrails.profile
Write-Host "Active guardrail profile: $activeProfile" -ForegroundColor Cyan

function Get-ProfileBehavior {
    param([string]$Profile)

    switch ($Profile) {
        "development" {
            return @{
                strictLevel = "medium"
                softLevel   = "high"
                debugLevel  = "verbose"
                autoRepair  = $true
                autoUpdate  = $true
            }
        }
        "production" {
            return @{
                strictLevel = "high"
                softLevel   = "low"
                debugLevel  = "minimal"
                autoRepair  = $false
                autoUpdate  = $true
            }
        }
        "testing" {
            return @{
                strictLevel = "high"
                softLevel   = "medium"
                debugLevel  = "high"
                autoRepair  = $false
                autoUpdate  = $false
            }
        }
        "recovery" {
            return @{
                strictLevel = "medium"
                softLevel   = "maximum"
                debugLevel  = "medium"
                autoRepair  = $true
                autoUpdate  = $true
            }
        }
        default {
            return @{
                strictLevel = "medium"
                softLevel   = "medium"
                debugLevel  = "medium"
                autoRepair  = $true
                autoUpdate  = $true
            }
        }
    }
}

$behavior = Get-ProfileBehavior -Profile $activeProfile
Write-Host ("Profile behavior: strict={0}, soft={1}, debug={2}, autoRepair={3}, autoUpdate={4}" -f `
    $behavior.strictLevel, $behavior.softLevel, $behavior.debugLevel, $behavior.autoRepair, $behavior.autoUpdate) `
    -ForegroundColor DarkCyan

# === DevAiCoreX Unified Guardrail Loader ===

function Resolve-Key {
    param($map, $key)

    if ($map -isnot [hashtable]) { return $null }

    if ($map.ContainsKey($key)) { return $map[$key] }

    # CBOR-LD numeric key compression map
    $ctx = @{
        "name"       = 1
        "kind"       = 2
        "version"    = 3
        "updated"    = 4
        "parentPath" = 5
        "schema"     = 6
        "lineage"    = 7
        "guardrails" = 8
    }

    if ($ctx.ContainsKey($key)) {
        $num = $ctx[$key]
        if ($map.ContainsKey($num)) { return $map[$num] }
    }

    return $null
}

function Load-GuardrailEntry {
    param([string]$path)

    $ext = [System.IO.Path]::GetExtension($path).ToLower()

    switch ($ext) {

        ".yaml" {
            $raw = Get-Content $path -Raw
            return (ConvertFrom-Yaml $raw)
        }

        ".yamlc" {
            $raw = Get-Content $path -Raw
            return (ConvertFrom-Yaml $raw)
        }

        ".json" {
            $raw = Get-Content $path -Raw
            return (ConvertFrom-Json $raw)
        }

        ".jsonc" {
            $raw = Get-Content $path -Raw
            $clean = ($raw -replace "//.*","")
            return (ConvertFrom-Json $clean)
        }

        ".cbor" {
            $tmp = "$env:TEMP\guardrail_decode.json"
            & "$Root\devai-cbor-decoder.ps1" `
                -CborInputPath $path `
                -JsonOutputPath $tmp

            $raw = Get-Content $tmp -Raw
            return (ConvertFrom-Json $raw)
        }

        ".cborld" {
            $tmp = "$env:TEMP\guardrail_decode.json"
            & "$Root\devai-cbor-decoder.ps1" `
                -CborInputPath $path `
                -JsonOutputPath $tmp

            $raw = Get-Content $tmp -Raw
            return (ConvertFrom-Json $raw)
        }

        default {
            throw "Unsupported guardrail file format: $ext"
        }
    }
}

# === Manifest + Module Enforcement ===

Write-Host "`n=== DevAiCoreX Guardrail Hooks ===`n" -ForegroundColor Cyan
Write-Host "Guardrail hooks loaded." -ForegroundColor DarkCyan
Write-Host ("Active guardrail profile: {0}" -f $activeProfile) -ForegroundColor Cyan
Write-Host ("Profile behavior: strict={0}, soft={1}, debug={2}, autoRepair={3}, autoUpdate={4}" -f `
    $behavior.strictLevel, $behavior.softLevel, $behavior.debugLevel, $behavior.autoRepair, $behavior.autoUpdate) `
    -ForegroundColor DarkCyan

Write-Host "[HOOK] Pre-Manifest" -ForegroundColor DarkGray
Write-Host "Validating and enforcing schema entries..." -ForegroundColor DarkGray

$manifestRaw = Get-Content $manifestPath -Raw
$manifestClean = ($manifestRaw -replace "//.*","")
$manifest = $manifestClean | ConvertFrom-Json

foreach ($entry in $manifest.entries) {
    $moduleName = Resolve-Key $entry "name"
    $moduleKind = Resolve-Key $entry "kind"

    Write-Host ("Checking: {0} ({1})" -f $moduleName, $moduleKind) -ForegroundColor Cyan

    # Try to locate any metadata file for this module (yamlc/jsonc/cbor/etc.)
    $moduleDir = Join-Path $Root $moduleKind
    $metaFiles = Get-ChildItem -Path $moduleDir -Filter "$moduleName.*" -ErrorAction SilentlyContinue

if (-not $metaFiles -or $metaFiles.Count -eq 0) {
    Write-Host ("[WARN] No metadata file found for module: {0}" -f $moduleName) -ForegroundColor DarkYellow
    continue
}

$metaPath = $metaFiles[0].FullName

try {
    $entryMap = Load-GuardrailEntry $metaPath
}
catch {
    Write-Host ("[FATAL] Unable to load guardrail entry for {0} from {1}: {2}" -f $moduleName, $metaPath, $_.Exception.Message) -ForegroundColor Red
    continue
}

    if ($entryMap -isnot [hashtable]) {
        Write-Host "[FATAL] Guardrail entry for $moduleName is not a map; skipping." -ForegroundColor Red
        continue
    }

    $entryVersion = Resolve-Key $entryMap "version"
    $entryUpdated = Resolve-Key $entryMap "updated"
    $entryParent  = Resolve-Key $entryMap "parentPath"
    $entryName    = Resolve-Key $entryMap "name"
    $entryKind    = Resolve-Key $entryMap "kind"

    if (-not $entryVersion) {
        Write-Host "[ERROR] Missing version in module: $moduleName" -ForegroundColor Red
    }

    if (-not $entryUpdated) {
        Write-Host "[ERROR] Missing updated in module: $moduleName" -ForegroundColor Red
    }

    if (-not $entryParent) {
        Write-Host "[ERROR] Missing parentPath in module: $moduleName" -ForegroundColor Red
    }

    if (-not $entryName -or $entryName -ne $moduleName) {
        Write-Host "[ERROR] name mismatch for module: $moduleName" -ForegroundColor Red
    }

    if (-not $entryKind -or $entryKind -ne $moduleKind) {
        Write-Host "[ERROR] kind mismatch for module: $moduleName" -ForegroundColor Red
    }

    # Example version enforcement against guardrail config
    if ($guard.guardrails.version) {
        if ($entryVersion -and $entryVersion -ne $guard.guardrails.version) {
            Write-Host "[WARN] Module $moduleName version ($entryVersion) differs from guardrail version ($($guard.guardrails.version))." -ForegroundColor DarkYellow
        }
    }
}

Write-Host "`nGuardrail enforcement complete.`n" -ForegroundColor Cyan

# Load manifest
$manifest = Get-Content $manifestPath | ConvertFrom-Json

# Call pre-manifest hook
if (Get-Command Invoke-PreManifestHook -ErrorAction SilentlyContinue) {
    Invoke-PreManifestHook
}

$report       = @()
$handoffTasks = @()

Write-Host "Validating and enforcing schema entries..." -ForegroundColor Yellow

# Helpers
function Get-SchemaPaths {
    param($Entry, [string]$Root)

    # parentPath may include .ps1; schemas use base name without extension
    $parentPath = Resolve-Key $entry "parentPath"
    $baseName   = [System.IO.Path]::GetFileNameWithoutExtension($parentPath)

    return @{
        yaml = "$Root\$baseName.yamlc"
        json = "$Root\$baseName.jsonc"
        cbor = "$Root\$baseName.cbor"
    }
}

function Test-JsoncValid {
    param([string]$Path)

    if (!(Test-Path $Path)) { return $false }
    try {
        $raw   = Get-Content $Path -Raw
        $clean = $raw -replace '\/\/.*', ''
        $null  = $clean | ConvertFrom-Json
        return $true
    } catch {
        return $false
    }
}

function Test-YamlIndentation {
    param([string]$Path)

    if (!(Test-Path $Path)) { return $false }
    $lines = Get-Content $Path
    foreach ($line in $lines) {
        if ($line -match "^\t") {
            return $false
        }
    }
    return $true
}

function Test-CborReadable {
    param([string]$Path)

    if (!(Test-Path $Path)) { return $false }
    $content = Get-Content $Path -Raw
    if ($content.Length -lt 4) { return $false }
    if ($content -notmatch '^[0-9a-fA-F]+$') { return $false }
    return $true
}

foreach ($entry in $manifest.entries) {

    $name = Resolve-Key $entry "name"
    $kind = Resolve-Key $entry "kind"

    $paths = Get-SchemaPaths -Entry $entry -Root $Root
    $yamlPath = $paths.yaml
    $jsonPath = $paths.json
    $cborPath = $paths.cbor

    Write-Host "`nChecking: $name ($kind)" -ForegroundColor White

    $entryReport = @{
        name    = $name
        kind    = $kind
        issues  = @()
        repairs = @()
        fatal   = @()
        debug   = @()
        tasks   = @()
    }

    $entryTasks = @()

    # STRICT ENFORCEMENT
    foreach ($fatal in $guard.guardrails.strict.fatalOn) {
        switch ($fatal) {

            "missingCoreSchema" {
                if ($kind -in @("engine","workspace","ai-context","game-engine","project")) {
                    $missing = @()
                    if (-not (Test-Path $yamlPath)) { $missing += "yamlc" }
                    if (-not (Test-Path $jsonPath)) { $missing += "jsonc" }
                    if (-not (Test-Path $cborPath)) { $missing += "cbor" }

                    if ($missing.Count -gt 0) {
                        $msg = ("{0}: {1}" -f Missing core schema components for ${name}, $missing -join ', ')
                        Write-Host "[FATAL] $msg" -ForegroundColor Red
                        $entryReport.fatal += $msg

                        $entryTasks += @{
                            type     = "regenerate-core-schema"
                            target   = $name
                            kind     = $kind
                            severity = "critical"
                            reason   = "missingCoreSchema"
                            missing  = $missing
                        }
                    }
                }
            }

            "corruptedCBOR" {
                if (Test-Path $cborPath) {
                    if (-not (Test-CborReadable $cborPath)) {
                        $msg = "CBOR unreadable or corrupted for ${name}"
                        Write-Host "[FATAL] $msg" -ForegroundColor Red
                        $entryReport.fatal += $msg

                        $entryTasks += @{
                            type     = "regenerate-cbor"
                            target   = $name
                            kind     = $kind
                            severity = "high"
                            reason   = "corruptedCBOR"
                        }
                    }
                }
            }

            "invalidJSONC" {
                if (Test-Path $jsonPath) {
                    if (-not (Test-JsoncValid $jsonPath)) {
                        $msg = "JSONC invalid for ${name}"
                        Write-Host "[FATAL] $msg" -ForegroundColor Red
                        $entryReport.fatal += $msg

                        $entryTasks += @{
                            type     = "fix-jsonc"
                            target   = $name
                            kind     = $kind
                            severity = "high"
                            reason   = "invalidJSONC"
                        }
                    }
                }
            }

            "invalidYAMLC" {
                if (Test-Path $yamlPath) {
                    if (-not (Test-YamlIndentation $yamlPath)) {
                        $msg = "YAML-C indentation or formatting invalid for ${name}"
                        Write-Host "[FATAL] $msg" -ForegroundColor Red
                        $entryReport.fatal += $msg

                        $entryTasks += @{
                            type     = "fix-yamlc"
                            target   = $name
                            kind     = $kind
                            severity = "high"
                            reason   = "invalidYAMLC"
                        }
                    }
                }
            }

            "missingRequiredFields" {
                $required      = $guard.guardrails.strict.requiredFields
                $missingFields = @()
                foreach ($field in $required) {
                    if (-not Resolve-Key $entry "PSObject".Properties.Name -contains $field) {
                        $missingFields += $field
                    }
                }
                if ($missingFields.Count -gt 0) {
                    $msg = ("{0}: {1}" -f Missing required fields in ${name}, $missingFields -join ', ')
                    Write-Host "[FATAL] $msg" -ForegroundColor Red
                    $entryReport.fatal += $msg

                    $entryTasks += @{
                        type     = "add-required-fields"
                        target   = $name
                        kind     = $kind
                        severity = "high"
                        reason   = "missingRequiredFields"
                        fields   = $missingFields
                    }
                }
            }
        }
    }

    # SOFT ENFORCEMENT (Auto-Repair)
    if ($behavior.autoRepair) {
        if (Get-Command Invoke-PreRepairHook -ErrorAction SilentlyContinue) {
            Invoke-PreRepairHook
        }

        foreach ($repair in $guard.guardrails.soft.autoRepair) {
            switch ($repair) {

                "missingCBOR" {
                    if (-not (Test-Path $cborPath)) {
                        $msg = "Regenerating CBOR placeholder for ${name}"
                        Write-Host "[REPAIR] $msg" -ForegroundColor Green
                        $guardCBOR = $guard.guardrails.cbor.placeholderHex
                        $guardCBOR | Set-Content $cborPath
                        $entryReport.repairs += $msg

                        $entryTasks += @{
                            type     = "confirm-cbor"
                            target   = $name
                            kind     = $kind
                            severity = "medium"
                            reason   = "missingCBOR"
                        }
                    }
                }

                "missingYAMLC" {
                    if (-not (Test-Path $yamlPath)) {
                        $msg = "Regenerating YAML-C placeholder for ${name}"
                        Write-Host "[REPAIR] $msg" -ForegroundColor Green
                        "placeholder: true" | Set-Content $yamlPath
                        $entryReport.repairs += $msg

                        $entryTasks += @{
                            type     = "regenerate-yamlc"
                            target   = $name
                            kind     = $kind
                            severity = "medium"
                            reason   = "missingYAMLC"
                        }
                    }
                }

                "missingJSONC" {
                    if (-not (Test-Path $jsonPath)) {
                        $msg = "Regenerating JSONC placeholder for ${name}"
                        Write-Host "[REPAIR] $msg" -ForegroundColor Green
                        '{ "placeholder": true }' | Set-Content $jsonPath
                        $entryReport.repairs += $msg

                        $entryTasks += @{
                            type     = "regenerate-jsonc"
                            target   = $name
                            kind     = $kind
                            severity = "medium"
                            reason   = "missingJSONC"
                        }
                    }
                }

                "missingDefaults" {
                    $defaults = $guard.guardrails.defaults
                    $applied  = @()
                    foreach ($key in $defaults.PSObject.Properties.Name) {
                        if (-not Resolve-Key $entry "PSObject".Properties.Name -contains $key) {
                            $entry | Add-Member -NotePropertyName $key -NotePropertyValue $defaults.$key -Force
                            $applied += $key
                        }
                    }
                    if ($applied.Count -gt 0) {
                        $msg = ("{0}: {1}" -f Applied defaults to ${name}, $applied -join ', ')
                        Write-Host "[REPAIR] $msg" -ForegroundColor Green
                        $entryReport.repairs += $msg

                        $entryTasks += @{
                            type     = "apply-defaults"
                            target   = $name
                            kind     = $kind
                            severity = "low"
                            reason   = "missingDefaults"
                            fields   = $applied
                        }
                    }
                }
            }
        }

        if (Get-Command Invoke-PostRepairHook -ErrorAction SilentlyContinue) {
            Invoke-PostRepairHook
        }
    }

    # AUTO-UPDATE (manifest-level)
    if ($behavior.autoUpdate) {
        if (Get-Command Invoke-PreUpdateHook -ErrorAction SilentlyContinue) {
            Invoke-PreUpdateHook
        }

        foreach ($update in $guard.guardrails.soft.autoUpdate) {
            switch ($update) {

                "outdatedVersions" {

                    # CBOR-safe version lookup
                    $entryVersion = Resolve-Key $entry "version"
                    $guardVersion = $guard.guardrails.version

                    if ($entryVersion -and $entryVersion -ne $guardVersion) {

                        $msg = ("Entry {0} version ({1}) differs from guardrail version ({2})" -f `
                            $name, $entryVersion, $guardVersion)

                        Write-Host ("[UPDATE] {0}" -f $msg) -ForegroundColor Cyan
                        $entryReport.issues += $msg
                    }
                }
            }
        }
    }
$entryTasks += @{
    type           = "update-version"
    target         = $name
    kind           = $kind
    severity       = "medium"
    reason         = "outdatedVersions"
    currentVersion = (Resolve-Key $entry "version")
    targetVersion  = $guard.guardrails.version
}

# CBOR-safe version update
$entryVersion = Resolve-Key $entry "version"
$guardVersion = $guard.guardrails.version

if ($entryVersion -ne $guardVersion) {

    $entryTasks += @{
        type           = "update-version"
        target         = $name
        kind           = $kind
        severity       = "medium"
        reason         = "outdatedVersions"
        currentVersion = $entryVersion
        targetVersion  = $guardVersion
    }

    # Update the entry map safely (works for JSON/YAML/CBOR/CBOR-LD)
# Ensure CBOR-decoded PSObject becomes a hashtable
$entryMap = $entry | ConvertTo-Json -Depth 20 | ConvertFrom-Json

$entryMap.version = $guardVersion
$entry = $entryMap
}

$entryUpdated = Resolve-Key $entry "updated"
if ($entryUpdated) {
    $msg = ("Timestamp present for {0} (updated={1}); validation pending." -f $name, $entryUpdated)


    $entryUpdated = Resolve-Key $entry "updated"

    if ($entryUpdated) {

        $msg = ("Timestamp present for {0} (updated={1}); validation pending." -f `
            $name, $entryUpdated)

        Write-Host ("[UPDATE] {0}" -f $msg) -ForegroundColor Cyan
        $entryReport.issues += $msg

        $entryTasks += @{
            type      = "validate-timestamp"
            target    = $name
            kind      = $kind
            severity  = "low"
            reason    = "staleTimestamps"
            timestamp = $entryUpdated
        }
    }
}

# Close switch-case
}

# POST-UPDATE HOOK
if (Get-Command Invoke-PostUpdateHook -ErrorAction SilentlyContinue) {
    Invoke-PostUpdateHook
}

# DEBUG CHECKS
foreach ($dbg in $guard.guardrails.debug.requiresAttention) {

    $msg = ("{0} check pending for {1}" -f $dbg, $name)

    if ($behavior.debugLevel -in @("verbose","high","medium")) {
        Write-Host ("[DEBUG] {0}" -f $msg) -ForegroundColor DarkYellow
    }

    $entryReport.debug += $msg

    $entryTasks += @{
        type     = "debug-check"
        target   = $name
        kind     = $kind
        severity = "info"
        reason   = $dbg
    }
}

$entryReport.tasks = $entryTasks
$report       += $entryReport
$handoffTasks += $entryTasks

# POST-MANIFEST HOOK
if (Get-Command Invoke-PostManifestHook -ErrorAction SilentlyContinue) {
    Invoke-PostManifestHook
}

# WRITE REPORT
$reportObject = @{
    mode      = $guard.guardrails.mode
    profile   = $activeProfile
    version   = $guard.guardrails.version
    schema    = $guard.guardrails.schemaVersion
    generated = (Get-Date).ToString("o")
    entries   = $report
}

$reportObject | ConvertTo-Json -Depth 10 | Set-Content $reportPath
Write-Host "`nWrote guardrail-report.jsonc" -ForegroundColor Cyan

# WRITE HANDOFF
$handoffObject = @{
    mode      = $guard.guardrails.mode
    profile   = $activeProfile
    version   = $guard.guardrails.version
    schema    = $guard.guardrails.schemaVersion
    generated = (Get-Date).ToString("o")
    tasks     = $handoffTasks
}

$handoffObject | ConvertTo-Json -Depth 10 | Set-Content $handoffPath
Write-Host "Wrote handoff.jsonc (AI Handoff)" -ForegroundColor Cyan

Write-Host "`nGuardrail validation and enforcement (Stage-8) complete.`n" -ForegroundColor Cyan
