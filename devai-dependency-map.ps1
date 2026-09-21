# DevAiCoreX Dependency Map
# Describes load order and dependencies between core modules.

Write-Host "Generating DevAiCoreX dependency map..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"
$mapFile = "$root\dependency-map.txt"

# Ordered load sequence (top-down)
$loadOrder = @(
    "environment.ps1",
    "creation-guardrails.ps1",
    "validation.ps1",
    "logging.ps1",
    "routing.ps1",
    "core.ps1",
    "profile-loader.ps1",
    "global-profile.ps1",
    "devshell-aliases.ps1",
    "devai-shell-tools.ps1",
    "devai-shell-profile.ps1",
    "startup-menu.ps1",
    "engine-register.ps1",
    "engine-loader.ps1",
    "workspace-register.ps1",
    "workspace-loader.ps1",
    "ai-context-register.ps1",
    "ai-context-loader.ps1",
    "game-engine-loader.ps1",
    "devai-bootstrap.ps1",
    "devai-run.ps1",
    "devai-build.ps1",
    "devai-test.ps1",
    "devai-deploy.ps1",
    "devai-clean-all.ps1"
)

# Simple dependency map (who depends on what)
$deps = @{
    "core.ps1"             = @("environment.ps1", "logging.ps1", "routing.ps1", "validation.ps1")
    "profile-loader.ps1"   = @("global-profile.ps1", "devshell-aliases.ps1")
    "devai-shell-profile.ps1" = @("devai-shell-tools.ps1", "devshell-aliases.ps1")
    "engine-loader.ps1"    = @("engine-register.ps1")
    "workspace-loader.ps1" = @("workspace-register.ps1")
    "ai-context-loader.ps1"= @("ai-context-register.ps1")
    "game-engine-loader.ps1" = @()
    "devai-bootstrap.ps1"  = @("environment.ps1","core.ps1","routing.ps1","logging.ps1","validation.ps1","engine-loader.ps1","workspace-loader.ps1","ai-context-loader.ps1","game-engine-loader.ps1","devai-shell-profile.ps1")
    "devai-run.ps1"        = @("devai-engine-run.ps1","devai-workspace-run.ps1","devai-ai-run.ps1","devai-game-run.ps1")
    "devai-build.ps1"      = @("devai-engine-build.ps1","devai-workspace-build.ps1","devai-ai-build.ps1","devai-game-build.ps1")
    "devai-test.ps1"       = @("devai-engine-test.ps1","devai-workspace-test.ps1","devai-ai-test.ps1","devai-game-test.ps1")
    "devai-deploy.ps1"     = @("devai-engine-deploy.ps1","devai-workspace-deploy.ps1","devai-ai-deploy.ps1","devai-game-deploy.ps1")
    "devai-clean-all.ps1"  = @("devai-engine-clean.ps1","devai-workspace-clean.ps1","devai-ai-clean.ps1","devai-game-clean.ps1")
}

$lines = @()
$lines += "DevAiCoreX Dependency Map"
$lines += "Generated: $(Get-Date)"
$lines += ""

$lines += "Load Order:"
$idx = 1
foreach ($m in $loadOrder) {
    $lines += "$idx. $m"
    $idx++
}
$lines += ""

$lines += "Dependencies:"
foreach ($key in $deps.Keys) {
    $requires = $deps[$key]
    if ($requires.Count -eq 0) {
        $lines += "$key -> (none)"
    } else {
        $lines += "$key -> " + ($requires -join ", ")
    }
}

$lines | Set-Content $mapFile

Write-Host "Dependency map written to: $mapFile" -ForegroundColor Green
