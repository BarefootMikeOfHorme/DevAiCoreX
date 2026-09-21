# DevAiCoreX GPU Check
# Detects NVIDIA, AMD, or Intel GPUs and reports driver status.

Write-Host "Checking GPU status..." -ForegroundColor Cyan

# NVIDIA
$nvidia = Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like "*NVIDIA*" }
if ($nvidia) {
    Write-Host "NVIDIA GPU detected: $($nvidia.Name)" -ForegroundColor Green
} else {
    Write-Host "No NVIDIA GPU detected." -ForegroundColor Yellow
}

# AMD
$amd = Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like "*AMD*" }
if ($amd) {
    Write-Host "AMD GPU detected: $($amd.Name)" -ForegroundColor Green
}

# Intel
$intel = Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like "*Intel*" }
if ($intel) {
    Write-Host "Intel GPU detected: $($intel.Name)" -ForegroundColor Green
}

Write-Host "GPU check complete." -ForegroundColor Green
