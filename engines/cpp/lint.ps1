Write-Host "[CPP LINT] Running C++ lint checks..."
clang-tidy *.cpp
cppcheck .
Write-Host "[CPP LINT] Linting complete."
