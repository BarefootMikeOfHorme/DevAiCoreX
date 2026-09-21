DevAiCoreX / DevCShell CLI — Concept & Architecture Document
============================================================

1. Overview
-----------
The DevAiCoreX / DevCShell CLI is a smart, adaptive, AI‑aware command interface
designed to unify engines, workspaces, AI contexts, game engines, and creation
tools under a single semantic command surface.

It is built to be:
- Human‑friendly
- Machine‑friendly
- AI‑friendly
- Extensible
- Context‑aware
- Safe
- Deterministic
- Modular

The CLI is not just a command parser — it is a semantic router capable of
understanding project context, engine type, workspace type, AI context,
toolchain availability, and creation mode.

2. Core Philosophy
------------------

2.1 Semantic Commands
Commands should be meaningful, not rigid.

Examples:
- devai build
- devai build engine rust
- devai build current
- devai run ai stable-diffusion
- devai deploy game unreal

The CLI resolves context automatically.

2.2 Context Awareness
The CLI understands:
- Active project
- Active engine
- Active workspace
- Active AI context
- Active game engine
- Creation Station mode
- Shell type (pwsh, wpshell, WSL)
- Toolchain availability
- Project type (game, AI, tool, library, converter, etc.)

2.3 Safety & Guardrails
The CLI prevents:
- Wrong engine for project
- Wrong workspace type
- Missing toolchains
- Unsafe builds
- Corrupted creation environments
- Invalid routing

2.4 Extensibility
Engines, workspaces, AI contexts, and game engines can register their own commands.

Examples:
Rust engine:
- devai rust fmt
- devai rust clippy
- devai rust build

Python workspace:
- devai python venv
- devai python lint
- devai python test

Stable Diffusion AI context:
- devai ai train
- devai ai infer
- devai ai profile

3. CLI Command Surface
----------------------

3.1 Top-Level Commands
init
detect
status
inspect
validate
build
run
test
deploy
clean
backup
restore
engine
workspace
ai
game
shell
version
update
help

3.2 Targets
engine
workspace
ai
game
project
shell
system

3.3 Examples
devai status
devai inspect engine rust
devai build workspace python
devai run ai stable-diffusion
devai deploy game unreal
devai clean project
devai backup all
devai restore project
devai update
devai version

4. Smart Routing Layer
----------------------

4.1 devai.ps1 — The Brainstem
This script:
- Parses commands
- Resolves context
- Loads correct module
- Applies guardrails
- Executes correct handler
- Returns structured output
- Supports human + machine modes

4.2 Routing Logic
Routing uses:
- project-detector.ps1
- validation.ps1
- routing.ps1
- creation-guardrails.ps1
- engine-loader.ps1
- workspace-loader.ps1
- ai-context-loader.ps1
- game-engine-loader.ps1

5. CLI Intelligence Layer
-------------------------
The CLI can answer:
- What engine should I use?
- What workspace is active?
- Is this project creation-ready?
- Is the toolchain installed?
- Is the environment valid?
- Is the AI context compatible?
- Is the build safe?
- Is the project corrupted?

This is done through:
- Context resolution
- Validation
- Guardrails
- Toolchain checks
- Project detection

6. Output Modes
---------------

6.1 Human Mode
Color-coded, readable, formatted.

6.2 Machine Mode (--json)
Structured JSON output for:
- AI agents
- Engines
- Workspaces
- IDEs
- DevCShell Creation Station
- External tools

Example:
{
  "project": "AssetConverterProRefinement",
  "engine": "rust",
  "workspace": "python",
  "aiContext": "stable-diffusion",
  "mode": "CreationStation",
  "toolchains": {
    "rust": "ok",
    "python": "ok",
    "ai": "ok"
  }
}

7. Extensibility Model
----------------------

7.1 Command Registration
Modules can register commands:
Register-DevAiCommand -Name "fmt" -Script "rust-fmt.ps1"
Register-DevAiCommand -Name "lint" -Script "python-lint.ps1"
Register-DevAiCommand -Name "train" -Script "sd-train.ps1"

7.2 Dynamic Command Loading
Commands load based on:
- Active engine
- Active workspace
- Active AI context
- Active game engine
- Creation Station mode

8. Creation Station Mode
------------------------
When DevCShell launches, CLI enters Creation Station Mode.

This mode enables:
- Creation engines
- Creation templates
- Creation toolchains
- Creation guardrails
- Creation debugging
- Creation linting
- Creation profiling

Commands:
devai create engine rust
devai create workspace python
devai create ai stable-diffusion
devai create project game-engine

9. CLI Modules to Generate
--------------------------

Core:
- devai.ps1
- devai-command-router.ps1
- devai-command-registry.ps1
- devai-context-resolver.ps1
- devai-cli-output.ps1
- devai-cli-guardrails.ps1
- devai-cli-help.ps1

Commands:
- devai-cli-init.ps1
- devai-cli-status.ps1
- devai-cli-build.ps1
- devai-cli-run.ps1
- devai-cli-test.ps1
- devai-cli-deploy.ps1
- devai-cli-clean.ps1

10. Summary
-----------
This document defines the entire conceptual architecture for the DevAiCoreX /
DevCShell CLI. It is now ready for code generation, module creation,
integration, testing, and finalization.

This is the blueprint.
