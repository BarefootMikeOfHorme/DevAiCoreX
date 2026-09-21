# wpshell — Normal Mode Shell  
Lightweight, Stable, Cross‑Platform Operational Environment

wpshell is the lightweight, stable, cross‑platform operational shell inside
DevAiCoreX. It is designed for everyday development tasks across Windows and
WSL2, providing a unified environment with consistent behavior, safe execution,
and predictable tooling. This document explains how wpshell works internally.

---

# 1. Purpose of wpshell

wpshell exists to provide a safe, stable, and consistent environment for:

- everyday development tasks
- Windows ↔ WSL2 command routing
- GPU passthrough validation
- logging and monitoring integration
- AI‑safe execution rules
- multi‑distro consistency (Ubuntu, Kali, Athena)

wpshell is intentionally lightweight and does not load creation engines,
AI‑context modules, or heavy toolchains unless explicitly requested.

---

# 2. How wpshell Loads

## 2.1 Windows PowerShell Startup
global-profile.ps1 loads, wpshell initializes, environment validation occurs.

## 2.2 WSL2 Shell Startup
journald-setup.sh, ai-logrotate.sh, gpu-validate.sh run, then wpshell loads.

## 2.3 Windows Terminal Startup
wpshell loads inside each tab unless VS2022 Developer PowerShell is detected.

---

# 3. Internal Components of wpshell

## 3.1 Environment Validator
Checks environment variables, WSL2 distros, GPU passthrough, logging, monitoring.

## 3.2 Command Router
Routes commands between Windows and WSL2.

## 3.3 Monitoring Integrator
Registers btop, bottom, glances.

## 3.4 AI‑Safe Execution Layer
Enforces thread caps, sandboxing, safe parallelism.

---

# 4. Behavior of wpshell

Lightweight operation, cross‑platform consistency, safe defaults.

---

# 5. What wpshell Does NOT Do

Does not load creation engines, AI‑context, workspaces, profiles, or VS2022
toolchains.

---

# 6. Extensibility

Custom routing rules, monitoring tools, and WSL2 setup scripts may be added.

---

# 7. Summary

wpshell is the stable, lightweight, cross‑platform operational shell inside
DevAiCoreX. It provides safe execution, unified routing, monitoring integration,
and consistent behavior across Windows and WSL2.
