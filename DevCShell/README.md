# DevCShell — Creation Station Mode

DevCShell is the high‑power creation environment for DevAiCoreX. It integrates
directly with VS2022 and provides multi‑language, multi‑engine creation
capabilities.

## Responsibilities

- Project type detection
- Language detection
- Creation engine loading
- Game engine environment loading
- Workspace generation
- AI‑context loading
- Hardened VS2022 toolchain integration
- Creation guardrails

## Behavior

Loads only via VS2022 Developer PowerShell or DevCShell.exe.

## Integration Points

- engine-loader.ps1
- profile-loader.ps1
- workspace-loader.ps1
- ai-context-loader.ps1
- game-engine-loader.ps1
