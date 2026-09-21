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
    $parentPath = $Entry.parentPath
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

    $name = $entry.name
    $kind = $entry.kind

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
                        $msg = "Missing core schema components for ${name}: $($missing -join ', ')"
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
                    if (-not $entry.PSObject.Properties.Name -contains $field) {
                        $missingFields += $field
                    }
                }
                if ($missingFields.Count -gt 0) {
                    $msg = "Missing required fields in ${name}: $($missingFields -join ', ')"
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
                        if (-not $entry.PSObject.Properties.Name -contains $key) {
                            $entry | Add-Member -NotePropertyName $key -NotePropertyValue $defaults.$key -Force
                            $applied += $key
                        }
                    }
                    if ($applied.Count -gt 0) {
                        $msg = "Applied defaults to ${name}: $($applied -join ', ')"
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
                    if ($entry.version -and $entry.version -ne $guard.guardrails.version) {
                        $msg = "Entry ${name} version ($($entry.version)) differs from guardrail version ($($guard.guardrails.version))"
                        Write-Host "[UPDATE] $msg" -ForegroundColor Cyan
                        $entryReport.issues += $msg

                        $entryTasks += @{
                            type           = "update-version"
                            target         = $name
                            kind           = $kind
                            severity       = "medium"
                            reason         = "outdatedVersions"
                            currentVersion = $entry.version
                            targetVersion  = $guard.guardrails.version
                        }

                        $entry.version = $guard.guardrails.version
                    }
                }

                "staleTimestamps" {
                    if ($entry.updated) {
                        $msg = "Timestamp present for ${name} (updated=$($entry.updated)); validation pending."
                        Write-Host "[UPDATE] $msg" -ForegroundColor Cyan
                        $entryReport.issues += $msg

                        $entryTasks += @{
                            type      = "validate-timestamp"
                            target    = $name
                            kind      = $kind
                            severity  = "low"
                            reason    = "staleTimestamps"
                            timestamp = $entry.updated
                        }
                    }
                }
            }
        }

        if (Get-Command Invoke-PostUpdateHook -ErrorAction SilentlyContinue) {
            Invoke-PostUpdateHook
        }
    }

    # DEBUG CHECKS
    foreach ($dbg in $guard.guardrails.debug.requiresAttention) {
        $msg = "$dbg check pending for ${name}"
        if ($behavior.debugLevel -in @("verbose","high","medium")) {
            Write-Host "[DEBUG] $msg" -ForegroundColor DarkYellow
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
}

# Call post-manifest hook
if (Get-Command Invoke-PostManifestHook -ErrorAction SilentlyContinue) {
    Invoke-PostManifestHook
}

# Write report
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

# Write handoff
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
