$root = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Draw-Line {
    param([int]$width = 80)
    Write-Host ("-" * $width) -ForegroundColor DarkGray
}

function Show-Header {
    Clear-Host
    Draw-Line
    Write-Host " DevAiCoreX Terminal Dashboard" -ForegroundColor Cyan
    Write-Host " Root: $root" -ForegroundColor Gray
    Write-Host " Time: $(Get-Date)" -ForegroundColor Gray
    Draw-Line
}

function Show-Stats {
    $modules = Get-ChildItem -Path $root -Filter "*.ps1"
    $total = $modules.Count
    $empty = ($modules | Where-Object { $_.Length -eq 0 }).Count

    Write-Host " Modules: $total" -ForegroundColor White
    Write-Host " Empty:   $empty" -ForegroundColor ($empty -gt 0 ? "Red" : "Green")
    Draw-Line
}

function Show-Modules {
    $modules = Get-ChildItem -Path $root -Filter "*.ps1" | Sort-Object Name
    Write-Host " Name                                      Size (bytes)   Status" -ForegroundColor Yellow
    Draw-Line

    foreach ($m in $modules) {
        $status = "OK"
        $color = "Green"
        if ($m.Length -eq 0) { $status = "EMPTY"; $color = "Red" }

        $name = $m.Name.PadRight(40)
        $size = $m.Length.ToString().PadLeft(10)
        Write-Host " $name $size   $status" -ForegroundColor $color
    }

    Draw-Line
}

function Show-Menu {
    Write-Host " [R] Refresh  [F] Run Finalize  [Q] Quit" -ForegroundColor Cyan
}

do {
    Show-Header
    Show-Stats
    Show-Modules
    Show-Menu

    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    $ch = $key.Character.ToString().ToUpper()

    if ($ch -eq "R") {
        continue
    } elseif ($ch -eq "F") {
        $finalize = Join-Path $root "devai-finalize.ps1"
        if (Test-Path $finalize) {
            Write-Host "Running finalize..." -ForegroundColor Yellow
            Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$finalize`""
            Start-Sleep -Seconds 2
        } else {
            Write-Host "devai-finalize.ps1 not found." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    } elseif ($ch -eq "Q") {
        break
    }

} while ($true)
