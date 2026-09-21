# DevAiCoreX Hash Report
# Generates SHA256 hashes for all .ps1 modules.

Write-Host "Generating DevAiCoreX hash report..." -ForegroundColor Cyan

$root = "C:\Users\Administrator\Desktop\DevAiCoreX"
$hashFile = "$root\hash-report.txt"

$lines = @()
$lines += "DevAiCoreX SHA256 Hash Report"
$lines += "Generated: $(Get-Date)"
$lines += ""

Get-ChildItem -Path $root -Filter "*.ps1" | Sort-Object Name | ForEach-Object {
    $path = $_.FullName
    $name = $_.Name

    $hash = Get-FileHash -Path $path -Algorithm SHA256
    $lines += "$name`t$($hash.Hash)"
}

$lines | Set-Content $hashFile

Write-Host "Hash report written to: $hashFile" -ForegroundColor Green
