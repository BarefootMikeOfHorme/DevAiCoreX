# DevAiCoreX Engine Docs Generator
# Creates documentation summaries for each engine.

Write-Host "Generating engine documentation..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\engines"
$docsRoot = "C:\Users\Administrator\Desktop\DevAiCoreX\docs\engines"

if (-not (Test-Path $docsRoot)) {
    New-Item -ItemType Directory -Path $docsRoot | Out-Null
}

$engines = Get-ChildItem $root -Directory

foreach ($e in $engines) {
    $docFile = "$docsRoot\$($e.Name).txt"
    $content = @()
    $content += "Engine: $($e.Name)"
    $content += "Path: $($e.FullName)"
    $content += "Files:"
    Get-ChildItem $e.FullName | ForEach-Object { $content += " - $($_.Name)" }
    $content | Set-Content $docFile
    Write-Host "Generated: $docFile" -ForegroundColor Green
}

Write-Host "Engine documentation complete." -ForegroundColor Green
