# DevAiCoreX Workspace Docs Generator
# Creates documentation summaries for each workspace.

Write-Host "Generating workspace documentation..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\workspaces"
$docsRoot = "C:\Users\Administrator\Desktop\DevAiCoreX\docs\workspaces"

if (-not (Test-Path $docsRoot)) {
    New-Item -ItemType Directory -Path $docsRoot | Out-Null
}

$workspaces = Get-ChildItem $root -Directory

foreach ($w in $workspaces) {
    $docFile = "$docsRoot\$($w.Name).txt"
    $content = @()
    $content += "Workspace: $($w.Name)"
    $content += "Path: $($w.FullName)"
    $content += "Files:"
    Get-ChildItem $w.FullName | ForEach-Object { $content += " - $($_.Name)" }
    $content | Set-Content $docFile
    Write-Host "Generated: $docFile" -ForegroundColor Green
}

Write-Host "Workspace documentation complete." -ForegroundColor Green
