# Shell Modes  
wpshell vs DevCShell — Dual‑Mode Operational Architecture

DevAiCoreX operates using two distinct shell modes, each designed for different
levels of power, safety, and creation capability. This document explains the
behavior, responsibilities, and integration points of both modes.

---

# 1. Overview of Shell Modes

DevAiCoreX uses:

- **wpshell (Normal Mode)**  
  Lightweight, stable, cross‑platform shell for everyday development.

- **DevCShell (Creation Station Mode)**  
  High‑power creation environment integrated with VS2022 and AI‑context.

Both modes share some infrastructure but behave differently depending on the
environment, project type, and user intent.

---

# 2. wpshell — Normal Mode

wpshell is designed for stability, safety, and cross‑platform consistency.

## 2.1 Purpose

- Provide a unified Windows + WSL2 development environment  
- Ensure safe, predictable behavior for everyday tasks  
- Maintain consistent logging, monitoring, and GPU validation  
- Avoid loading heavy creation engines unless explicitly required  

## 2.2 Behavior

wpshell loads automatically when:

- Windows PowerShell starts  
- pwsh starts  
- any WSL2 distro shell starts  

It performs:

- environment validation  
- GPU passthrough checks  
- logging setup  
- monitoring registration  
- safe‑mode execution rules  

## 2.3 Responsibilities

- Command routing between Windows and WSL2  
- Multi‑distro consistency (Ubuntu, Kali, Athena)  
- Terminal monitoring integration  
- AI‑safe execution (thread caps, sandboxing)  
- Lightweight environment setup  

## 2.4 What wpshell Does NOT Do

- Does not load creation engines  
- Does not generate workspaces  
- Does not load AI‑context  
- Does not perform project detection  
- Does not modify VS2022 environments  

wpshell is intentionally minimal and safe.

---

# 3. DevCShell — Creation Station Mode

DevCShell is the high‑power creation environment used for project generation,
engine loading, workspace creation, and AI‑context integration.

## 3.1 Purpose

- Provide a hardened creation environment  
- Integrate directly with VS2022 Developer PowerShell  
- Load creation engines based on project type  
- Apply AI‑context rules, prompts, and lineage  
- Generate multi‑language workspaces  
- Initialize game engine creation environments  

## 3.2 Behavior

DevCShell loads only when:

- VS2022 Developer PowerShell starts  
- DevCShell.exe is launched  
- Creation Station mode is explicitly requested  

It performs:

- project type detection  
- language detection  
- engine loading  
- workspace generation  
- AI‑context loading  
- creation guardrail enforcement  

## 3.3 Responsibilities

- Multi‑language creation (C, C++, Rust, Python, PyO3, Web)  
- Game engine creation (Unreal, Unity, Godot, CryEngine)  
- AI‑context integration (rules, prompts, lineage, memory)  
- Hardened VS2022 toolchain integration  
- Creation safety enforcement  

## 3.4 What DevCShell Does NOT Do

- Does not run in normal Windows PowerShell  
- Does not load in WSL2 shells  
- Does not operate without VS2022 toolchains  
- Does not perform lightweight routing or monitoring  

DevCShell is intentionally powerful and creation‑focused.

---

# 4. Mode Switching Logic

DevAiCoreX determines which shell to load based on environment:

## 4.1 Windows Terminal → wpshell
If the shell is opened from Windows Terminal, wpshell loads.

## 4.2 WSL2 → wpshell
If the shell is opened inside any WSL2 distro, wpshell loads.

## 4.3 VS2022 Developer PowerShell → DevCShell
If the shell is opened from VS2022 Developer PowerShell, DevCShell loads.

## 4.4 Manual Override
Users may manually launch DevCShell via:

DevCShell.exe

---

# 5. Safety Differences Between Modes

## 5.1 wpshell Safety
- AI‑safe execution  
- thread caps  
- GPU validation  
- sandboxed routing  
- minimal environment mutation  

## 5.2 DevCShell Safety
- creation guardrails  
- engine constraints  
- workspace validation  
- AI‑context enforcement  
- hardened VS2022 toolchain rules  

---

# 6. Summary

wpshell and DevCShell form the dual‑mode operational core of DevAiCoreX.  
wpshell provides stability and safety for everyday development, while DevCShell
provides the power and intelligence required for multi‑language, AI‑augmented
project creation.

Understanding the differences between these modes is essential for both human
developers and AI agents operating within DevAiCoreX.
