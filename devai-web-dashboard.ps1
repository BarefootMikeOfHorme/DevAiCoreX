$root = "C:\Users\Administrator\Desktop\DevAiCoreX"
$dashboardHtml = Join-Path $root "dashboard.html"

$modules = Get-ChildItem -Path $root -Filter "*.ps1" | Sort-Object Name

$html = @()
$html += "<!DOCTYPE html>"
$html += "<html>"
$html += "<head>"
$html += "<meta charset='utf-8' />"
$html += "<title>DevAiCoreX Web Dashboard</title>"
$html += "<style>"
$html += "body { background:#1e1e1e; color:#ffffff; font-family: Consolas, monospace; }"
$html += "table { border-collapse: collapse; width: 100%; }"
$html += "th, td { border: 1px solid #444; padding: 6px; }"
$html += "th { background:#333; }"
$html += ".ok { color:#8bc34a; }"
$html += ".empty { color:#ff5722; }"
$html += "</style>"
$html += "</head>"
$html += "<body>"
$html += "<h1>DevAiCoreX Web Dashboard</h1>"
$html += "<p>Root: $root</p>"
$html += "<p>Generated: $(Get-Date)</p>"
$html += "<table>"
$html += "<tr><th>Module</th><th>Size (bytes)</th><th>Status</th></tr>"

foreach ($m in $modules) {
    $status = "OK"
    $cls = "ok"
    if ($m.Length -eq 0) { $status = "EMPTY"; $cls = "empty" }
    $html += "<tr><td>$($m.Name)</td><td>$($m.Length)</td><td class='$cls'>$status</td></tr>"
}

$html += "</table>"
$html += "<p>Total modules: $($modules.Count)</p>"
$html += "</body>"
$html += "</html>"

$html | Set-Content $dashboardHtml -Encoding UTF8

Write-Host "DevAiCoreX web dashboard written to: $dashboardHtml" -ForegroundColor Green
Start-Process $dashboardHtml
