# DevAiCoreX Documentation Index Generator
# Builds a master index of all generated documentation.

Write-Host "Building documentation index..." -ForegroundColor Cyan

$docsRoot = "C:\Users\Administrator\Desktop\DevAiCoreX\docs"
$indexFile = "$docsRoot\index.txt"

if (-not (Test-Path $docsRoot)) {
    New-Item -ItemType Directory -Path $docsRoot | Out-Null
}

$index = @()
$index += "DevAiCoreX Documentation Index"
$index += "Generated: $(Get-Date)"
$index += ""

$folders = Get-ChildItem $docsRoot -Directory

foreach ($f in $folders) {
    $index += "Category: $($f.Name)"
    $files = Get-ChildItem $f.FullName -File
    foreach ($file in $files) {
        $index += " - $($file.Name)"
    }
    $index += ""
}

$index | Set-Content $indexFile

Write-Host "Documentation index created: $indexFile" -ForegroundColor Green
