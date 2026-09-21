# DevAiCoreX Startup Menu
# Provides an interactive menu to launch engines, workspaces, and tools.

Write-Host "DevAiCoreX Startup Menu" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

function Show-StartupMenu {
    Write-Host ""
    Write-Host "1) Load engines"
    Write-Host "2) Load workspaces"
    Write-Host "3) Load AI contexts"
    Write-Host "4) Show PATH entries"
    Write-Host "5) Exit"
    Write-Host ""

    $choice = Read-Host "Select an option"

    switch ($choice) {
        "1" {
            . "$Global:DevAiRoot\engine-loader.ps1"
        }
        "2" {
            . "$Global:DevAiRoot\workspace-loader.ps1"
        }
        "3" {
            . "$Global:DevAiRoot\ai-context-loader.ps1"
        }
        "4" {
            $env:PATH -split ";" | Where-Object { $_ -like "*DevAiCoreX*" }
        }
        "5" {
            Write-Host "Exiting startup menu." -ForegroundColor Yellow
            return
        }
        default {
            Write-Host "Invalid choice." -ForegroundColor Red
        }
    }

    Show-StartupMenu
}

Show-StartupMenu
