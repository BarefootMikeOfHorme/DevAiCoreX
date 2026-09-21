\# DevAiCoreX CLI — Routing Architecture



This document defines how the DevAiCoreX CLI routes commands to engines, workspaces, AI contexts, game engines, and system modules. Routing is semantic, context-aware, and safe. The routing layer ensures that every command resolves correctly based on the active project environment.



\---



\# 1. Purpose of CLI Routing



CLI routing determines:



\- which module handles a command

\- which engine or workspace is active

\- which AI context or game engine applies

\- which guardrails must be enforced

\- how ambiguous commands are resolved

\- how semantic commands map to real operations



Routing is the “brainstem” of the CLI.



\---



\# 2. Routing Flow Overview



The routing system follows this sequence:



1\. Parse the command

2\. Resolve context (engine, workspace, AI, game)

3\. Validate toolchains and guardrails

4\. Match command to a handler

5\. Execute the handler

6\. Return human or machine-friendly output



This ensures predictable behavior across all project types.



\---



\# 3. Routing Components



Routing uses several internal modules:



\- devai-command-router.ps1

\- devai-command-registry.ps1

\- devai-context-resolver.ps1

\- devai-cli-guardrails.ps1

\- project-detector.ps1

\- engine-loader.ps1

\- workspace-loader.ps1

\- ai-context-loader.ps1

\- game-engine-loader.ps1



Each module contributes to safe, accurate routing.



\---



\# 4. Command Parsing



The CLI parses commands into:



command

target

subcommand

flags

arguments



Example:



devai build engine rust --json



Parsed as:



command: build

target: engine

subcommand: rust

flags: --json

arguments: none



\---



\# 5. Context Resolution



Context resolution determines:



\- active engine

\- active workspace

\- active AI context

\- active game engine

\- active project type

\- active shell mode

\- Creation Station mode



Context resolution uses:



project-detector.ps1

devai-context-resolver.ps1

devai-cli-context-cache.ps1



This allows semantic commands like:



devai build

devai run

devai test



to resolve correctly without specifying engine or workspace.



\---



\# 6. Handler Resolution



Once context is known, routing selects the correct handler.



Handlers may come from:



\- engine modules

\- workspace modules

\- AI context modules

\- game engine modules

\- CLI core modules

\- Creation Station modules



Example:



devai build



If engine = rust:

handler = rust-build.ps1



If workspace = python:

handler = python-build.ps1



If game engine = unreal:

handler = unreal-build.ps1



Routing always selects the correct handler automatically.



\---



\# 7. Guardrail Enforcement



Before executing a handler, routing enforces:



\- engine compatibility

\- workspace compatibility

\- AI context compatibility

\- game engine compatibility

\- toolchain validation

\- safe build rules

\- safe generation rules



If a violation occurs, routing returns:



\- standardized error code

\- human-friendly message

\- machine-friendly JSON (if requested)



\---



\# 8. Semantic Routing Examples



Example 1:

devai build



Routing determines:

\- active engine

\- active workspace

\- correct build handler



Example 2:

devai ai train



Routing determines:

\- active AI context

\- correct training handler



Example 3:

devai create engine rust



Routing enters Creation Station mode and selects:

\- engine creation handler



Example 4:

devai deploy



Routing determines:

\- project type

\- correct deployment handler



\---



\# 9. Machine-Friendly Routing



All routing supports:



\--json



Example:



devai status --json



Routing returns structured JSON:



{

&#x20; "engine": "rust",

&#x20; "workspace": "python",

&#x20; "aiContext": "stable-diffusion",

&#x20; "gameEngine": null,

&#x20; "toolchains": {

&#x20;   "rust": "ok",

&#x20;   "python": "ok",

&#x20;   "ai": "ok"

&#x20; }

}



This is used by AI agents, IDEs, and automation tools.



\---



\# 10. Extensible Routing



Engines, workspaces, AI contexts, and game engines can register new routing entries.



Example:



Register-DevAiCommand -Name "fmt" -Script "rust-fmt.ps1"

Register-DevAiCommand -Name "venv" -Script "python-venv.ps1"

Register-DevAiCommand -Name "train" -Script "sd-train.ps1"



Routing automatically incorporates new commands.



\---



\# 11. Summary



cli-routing.md defines how DevAiCoreX CLI commands are parsed, resolved, validated, and executed. Routing is semantic, context-aware, safe, and extensible. It ensures that every command maps to the correct handler across engines, workspaces, AI contexts, game engines, and Creation Station mode.



