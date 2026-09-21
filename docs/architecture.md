# DevAiCoreX Architecture  
Dual‑Mode AI‑Augmented Development System

DevAiCoreX is a structured, extensible, AI‑aware development architecture built
to unify Windows, WSL2, VS2022, and multi‑language creation engines into a
single predictable environment. It is designed for both human developers and AI
agents, enabling safe, consistent, high‑performance project creation.

---

# 1. Core Architectural Principles

DevAiCoreX is built on five foundational principles:

## 1.1 Dual‑Mode Operation
Two shells operate in parallel:

- wpshell (Normal Mode): stable, lightweight, cross‑platform environment.
- DevCShell (Creation Station Mode): high‑power creation environment integrated
  with VS2022 and AI‑context.

Each mode has its own responsibilities, safety rules, and loading behavior.

## 1.2 Windows + WSL2 Hybrid Compute
DevAiCoreX treats Windows and WSL2 as a unified compute fabric:

- Windows Terminal is the gateway  
- VS2022 is the hardened IDE hub  
- WSL2 distros (Ubuntu, Kali, Athena) act as compute engines  
- GPU passthrough is validated automatically  
- Logging and monitoring are unified across environments  

## 1.3 Modular Creation Engines
Creation engines define how DevCShell builds and generates projects:

- C  
- C++  
- Rust  
- Python  
- PyO3  
- Mixed  
- AI  
- GPU  

Each engine contains templates, build logic, debug logic, and AI‑context.

## 1.4 Workspace‑Driven Project Structure
Workspaces define the folder layout and environment for each language:

- src/  
- include/  
- cargo/  
- venv/  
- bindings/  
- api/  

Workspaces are generated automatically by DevCShell based on project type.

## 1.5 AI‑Context Integration
AI‑context provides:

- rules  
- prompts  
- lineage  
- memory  

This ensures consistent behavior and safe generation across all engines.

---

# 2. System Components

DevAiCoreX is composed of the following major subsystems:

## 2.1 Shell Layer
- wpshell  
- DevCShell  
- PowerShell profiles  
- WSL2 setup scripts  

The shell layer handles environment detection, routing, validation, and safety.

## 2.2 Engine Layer
- C / C++ / Rust / Python / PyO3  
- Mixed / AI / GPU  
- Game engines (Unreal, Unity, Godot, CryEngine)  

Engines define how projects are built, analyzed, and generated.

## 2.3 Workspace Layer
Workspaces define the structure of generated projects.

## 2.4 AI‑Context Layer
AI‑context governs how AI agents interact with DevAiCoreX.

## 2.5 Monitoring Layer
Terminal + Web UI monitoring stack:

- btop  
- bottom  
- glances  
- Grafana  
- Prometheus  
- Netdata  

---

# 3. Execution Flow

This section describes how DevAiCoreX behaves during normal operation.

## 3.1 Windows Terminal Startup
When Windows Terminal opens:

1. global-profile.ps1 loads  
2. wpshell initializes  
3. WSL2 distros are validated  
4. monitoring tools are registered  
5. environment is stabilized  

## 3.2 VS2022 Developer PowerShell Startup
When VS2022 Developer PowerShell opens:

1. vs2022-profile.ps1 loads  
2. DevCShell initializes  
3. project type is detected  
4. correct engines are loaded  
5. workspace is generated  
6. AI‑context is applied  

## 3.3 WSL2 Startup
When any WSL2 distro opens:

1. journald-setup.sh ensures logging  
2. ai-logrotate.sh ensures safe log rotation  
3. gpu-validate.sh checks GPU passthrough  
4. wpshell loads  

---

# 4. Safety Architecture

DevAiCoreX includes multiple safety layers:

## 4.1 AI‑Safe Execution
- thread caps  
- GPU validation  
- sandboxed creation engines  
- guardrails for generation  

## 4.2 Environment Safety
- WSL2 logging  
- Windows Terminal safe settings  
- VS2022 hardened profiles  

## 4.3 Creation Safety
- engine guardrails  
- profile constraints  
- workspace validation  

---

# 5. Extensibility

DevAiCoreX is designed to be extended:

## 5.1 Custom Engines
Add under:
engines/custom/<engine-name>

## 5.2 Custom Game Engines
Add under:
game-engines/custom/<engine-name>

## 5.3 Custom Profiles
Add under:
profiles/custom/<profile-name>

## 5.4 Custom AI‑Context
Add under:
ai-context/custom/<module-name>

---

# 6. Summary

DevAiCoreX is a unified, dual‑mode, AI‑augmented development architecture that
brings together Windows, WSL2, VS2022, creation engines, workspaces, and
AI‑context into a single predictable system.

This document defines the high‑level architecture used by both human developers
and AI agents to operate safely and effectively within DevAiCoreX.
