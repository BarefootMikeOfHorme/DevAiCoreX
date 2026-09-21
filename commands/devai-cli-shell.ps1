Write-Host "[SHELL] Shell mode command invoked."

param(
    [string]$Mode
)

switch ($Mode) {

    "pwsh" {
        Write-Host "[SHELL] Switching to PowerShell mode..."
    }

    "wpshell" {
        Write-Host "[SHELL] Switching to Workspace Shell mode..."
    }

    "devcshell" {
        Write-Host "[SHELL] Switching to Creation Station Shell..."
    }

    default {
        Write-Host "Usage: devai shell <pwsh|wpshell|devcshell>"
    }
}

Write-Host "[SHELL] Completed."
