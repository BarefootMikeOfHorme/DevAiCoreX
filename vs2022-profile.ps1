# DevAiCoreX Visual Studio 2022 Toolchain Profile
# Loads MSVC, build tools, and developer command environment.

Write-Host "Loading Visual Studio 2022 toolchain profile..." -ForegroundColor Cyan

$Global:DevAiRoot = "C:\Users\Administrator\Desktop\DevAiCoreX"

# Default VS2022 installation path
$vsPath = "C:\Program Files\Microsoft Visual Studio\2022\Community"
$vcTools = "$vsPath\VC\Tools\MSVC"
$vsDevCmd = "$vsPath\Common7\Tools\VsDevCmd.bat"

# Verify VS installation
if (-not (Test-Path $vsPath)) {
    Write-Host "Visual Studio 2022 not found at: $vsPath" -ForegroundColor Red
    return
}

Write-Host "VS2022 installation found." -ForegroundColor Green

# Load developer command environment
if (Test-Path $vsDevCmd) {
    Write-Host "Initializing VS Developer Command Prompt..." -ForegroundColor Yellow
    cmd.exe /c "`"$vsDevCmd`" -arch=x64 -host_arch=x64"
    Write-Host "VS Developer environment loaded." -ForegroundColor Green
} else {
    Write-Host "VsDevCmd.bat missing — cannot initialize MSVC environment." -ForegroundColor Red
}

# Detect MSVC version folder
$msvcVersion = Get-ChildItem $vcTools | Sort-Object Name -Descending | Select-Object -First 1

if ($msvcVersion) {
    $msvcBin = "$($msvcVersion.FullName)\bin\Hostx64\x64"
    $msvcInclude = "$($msvcVersion.FullName)\include"
    $msvcLib = "$($msvcVersion.FullName)\lib\x64"

    Write-Host "MSVC Version: $($msvcVersion.Name)" -ForegroundColor Green

    # Inject into PATH
    $env:PATH += ";$msvcBin"
    Write-Host "MSVC bin added to PATH." -ForegroundColor Yellow

    # Export environment variables
    $env:MSVC_BIN = $msvcBin
    $env:MSVC_INCLUDE = $msvcInclude
    $env:MSVC_LIB = $msvcLib

    Write-Host "MSVC environment variables set." -ForegroundColor Green
} else {
    Write-Host "No MSVC toolchain found inside VS2022." -ForegroundColor Red
}

# CMake detection
$cmakePath = "C:\Program Files\CMake\bin\cmake.exe"
if (Test-Path $cmakePath) {
    $env:PATH += ";C:\Program Files\CMake\bin"
    Write-Host "CMake detected and added to PATH." -ForegroundColor Green
} else {
    Write-Host "CMake not found — builds may fail." -ForegroundColor Red
}

# Ninja detection
$ninjaPath = "C:\Program Files\Ninja\ninja.exe"
if (Test-Path $ninjaPath) {
    $env:PATH += ";C:\Program Files\Ninja"
    Write-Host "Ninja detected and added to PATH." -ForegroundColor Green
} else {
    Write-Host "Ninja not found — consider installing for faster builds." -ForegroundColor Yellow
}

Write-Host "VS2022 toolchain profile loaded successfully." -ForegroundColor Green
