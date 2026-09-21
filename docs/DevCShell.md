# DevCShell — Creation Station Shell  
High‑Power, AI‑Augmented Creation Environment

DevCShell is the high‑power creation shell inside DevAiCoreX. It is responsible
for multi‑language project generation, engine loading, workspace creation,
AI‑context integration, and hardened VS2022 toolchain usage. This document
explains DevCShell’s internal behavior, responsibilities, and architecture.

---

# 1. Purpose of DevCShell

DevCShell exists to provide a structured, intelligent, and fully integrated
environment for multi‑language project creation, game engine initialization,
AI‑assisted generation, workspace creation, engine loading, profile loading,
AI‑context loading, and toolchain validation.

---

# 2. How DevCShell Loads

## 2.1 VS2022 Developer PowerShell Startup
vs2022-profile.ps1 loads, DevCShell initializes, project type is detected,
engines load, workspace generates, AI‑context applies.

## 2.2 Manual Launch
DevCShell.exe loads the environment.

## 2.3 Explicit Creation Request
devcshell --create <project-type> hands off from wpshell.

---

# 3. Internal Components

Engine loader, workspace generator, profile loader, AI‑context loader, game
engine loader, toolchain validator.

---

# 4. Behavior

High‑power creation mode, structured generation, AI‑augmented creation.

---

# 5. What DevCShell Does NOT Do

Does not act as a normal shell, does not route commands, does not run in WSL2,
does not operate without VS2022 toolchains.

---

# 6. Extensibility

Custom engines, profiles, workspaces, AI‑context modules.

---

# 7. Summary

DevCShell is the high‑power creation shell inside DevAiCoreX, responsible for
multi‑language project generation, engine loading, workspace creation, and
AI‑context integration.
