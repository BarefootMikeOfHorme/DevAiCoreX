Write-Host "[CPP BUILD] Building C++ engine..."
cmake -S . -B build
cmake --build build
Write-Host "[CPP BUILD] Build complete."
