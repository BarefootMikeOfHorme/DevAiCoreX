Write-Host "[RUST BUILD] Starting Rust engine build..."
cargo fmt
cargo clippy --fix --allow-dirty --allow-staged
cargo check
cargo build
Write-Host "[RUST BUILD] Build complete."
