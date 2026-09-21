Write-Host "[GO BUILD] Building Go engine..."
go mod tidy
go build
Write-Host "[GO BUILD] Build complete."
