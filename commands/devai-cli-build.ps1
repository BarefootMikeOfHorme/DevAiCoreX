Write-Host "[BUILD] Starting project build..."

if (-not (Test-Path "./engine.yaml")) {
    Write-Host "[BUILD] No engine.yaml found. Cannot build."
    exit 1
}

$engine = (Get-Content "./engine.yaml" -Raw).Trim()
Write-Host "[BUILD] Using engine: $engine"

switch ($engine) {

    "rust" {
        Write-Host "[BUILD] Running cargo build..."
        cargo build
    }

    "python" {
        Write-Host "[BUILD] Packaging Python project..."
        python setup.py build
    }

    "cpp" {
        Write-Host "[BUILD] Compiling C++ sources..."
        Write-Host "[BUILD] (C++ build logic placeholder)"
    }

    default {
        Write-Host "[BUILD] Unknown engine: $engine"
        exit 1
    }
}

Write-Host "[BUILD] Build completed."
