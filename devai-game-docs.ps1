# DevAiCoreX Game Engine Docs Generator
# Creates documentation summaries for each game engine.

Write-Host "Generating game engine documentation..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\game-engines"
$docsRoot = "C:\Users\Administrator\Desktop\DevAiCoreX\docs\game-engines"

if (-not (Test-Path $docsRoot)) {
    New-Item -ItemType Directory -Path $docsRoot | Out-Null
}

$engines = Get-ChildItem $root -Directory

foreach ($g in $engines) {
    $docFile = "$docsRoot\$($g.Name).txt"
    $content = @()
    $content += "Game Engine: $($g.Name)"
    $content += "Path: $($g.FullName)"
    $content += "Files:"
    Get-ChildItem $g.FullName | ForEach-Object { $content += " - $($_.Name)" }
    $content | Set-Content $docFile
    Write-Host "Generated: $docFile" -ForegroundColor Green
}

Write-Host "Game engine documentation complete." -ForegroundColor Green
