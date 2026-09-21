Write-Host "[RUST LINT] Running Rust lint checks..."
cargo fmt --check
cargo clippy
Write-Host "[RUST LINT] Linting complete."
