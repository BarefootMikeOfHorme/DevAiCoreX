Write-Host "[UNITY BUILD] Building Unity project..."
unity-editor -quit -batchmode -projectPath . -buildWindows64Player build/game.exe
Write-Host "[UNITY BUILD] Build complete."
