# DevAiCoreX AI Context Docs Generator
# Creates documentation summaries for each AI context.

Write-Host "Generating AI context documentation..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX\ai-context"
$docsRoot = "C:\Users\Administrator\Desktop\DevAiCoreX\docs\ai-context"

if (-not (Test-Path $docsRoot)) {
    New-Item -ItemType Directory -Path $docsRoot | Out-Null
}

$contexts = Get-ChildItem $root -Directory

foreach ($c in $contexts) {
    $docFile = "$docsRoot\$($c.Name).txt"
    $content = @()
    $content += "AI Context: $($c.Name)"
    $content += "Path: $($c.FullName)"
    $content += "Files:"
    Get-ChildItem $c.FullName | ForEach-Object { $content += " - $($_.Name)" }
    $content | Set-Content $docFile
    Write-Host "Generated: $docFile" -ForegroundColor Green
}

Write-Host "AI documentation complete." -ForegroundColor Green
