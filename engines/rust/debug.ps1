Write-Host "[RUST DEBUG] Running Rust engine with debug flags..."
$env:RUST_BACKTRACE = 1
cargo run
Write-Host "[RUST DEBUG] Debug session complete."
