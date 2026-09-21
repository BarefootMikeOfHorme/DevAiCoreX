# wpshell — Normal Mode Shell

wpshell is the lightweight, stable, cross‑platform operational shell for
DevAiCoreX. It is used for everyday development across Windows and WSL2.

## Responsibilities

- Unified command routing (Windows ↔ WSL2)
- Multi‑distro consistency
- GPU passthrough validation
- AI‑safe parallel execution
- Logging and session tracking
- Environment validation
- Monitoring integration

## Behavior

Loads automatically in Windows PowerShell, pwsh, and all WSL2 distros.

## Integration Points

- scripts/powershell-profile/global-profile.ps1
- scripts/wsl/*/journald-setup.sh
- monitoring/terminal/*
