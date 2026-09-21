\# DevAiCoreX CLI — Command Reference



This document defines all top-level DevAiCoreX CLI commands, their purpose, and how they interact with engines, workspaces, AI contexts, game engines, and Creation Station mode. All commands are semantic, context-aware, and safe by design.



\---



\# 1. Top-Level Commands



The DevAiCoreX CLI supports the following top-level commands:



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

create



Each command is context-aware and may behave differently depending on the active engine, workspace, AI context, game engine, or Creation Station mode.



\---



\# 2. Command Categories



Commands fall into several categories:



System Commands:

init

detect

status

inspect

validate

version

update



Build Commands:

build

run

test

deploy

clean



Project Commands:

backup

restore



Engine Commands:

engine <subcommand>



Workspace Commands:

workspace <subcommand>



AI Commands:

ai <subcommand>



Game Engine Commands:

game <subcommand>



Creation Commands:

create <target>



Shell Commands:

shell <subcommand>



Help:

help



\---



\# 3. Command Descriptions



init

Initializes a new DevAiCoreX project using the active engine and workspace.



detect

Detects the current project type, engine, workspace, AI context, and game engine.



status

Displays the current CLI context including engine, workspace, AI context, game engine, toolchains, and Creation Station mode.



inspect

Shows detailed information about the active engine, workspace, AI context, or game engine.



validate

Runs validation checks including guardrails, toolchain checks, workspace structure checks, and engine compatibility.



build

Builds the current project using the active engine and workspace.



run

Runs the project using the active engine or workspace runtime.



test

Executes tests for the active engine or workspace.



deploy

Deploys the project using engine-specific or workspace-specific deployment logic.



clean

Cleans build artifacts, caches, temporary files, and workspace clutter.



backup

Creates a backup of the project including workspace metadata and lineage.



restore

Restores a project from a backup.



engine <subcommand>

Engine-specific commands such as fmt, clippy, build, debug, metadata, etc.



workspace <subcommand>

Workspace-specific commands such as venv, lint, test, api, bindings, etc.



ai <subcommand>

AI context-specific commands such as train, infer, profile, optimize, etc.



game <subcommand>

Game engine-specific commands such as build, cook, package, deploy, etc.



shell <subcommand>

Shell-specific commands such as profile, reload, inspect, mode, etc.



version

Shows DevAiCoreX version and CLI version.



update

Updates DevAiCoreX modules, engines, workspaces, and CLI components.



help

Shows help for any command or subcommand.



create <target>

Creation Station mode command for generating engines, workspaces, AI contexts, game engines, or full projects.



\---



\# 4. Semantic Command Behavior



Commands are semantic, meaning:



devai build

devai build engine rust

devai build workspace python

devai build current



All resolve correctly based on context.



The CLI determines:



\- active engine

\- active workspace

\- active AI context

\- active game engine

\- active project type

\- active shell mode

\- Creation Station mode



This allows flexible, natural command usage.



\---



\# 5. Machine-Friendly Mode



All commands support:



\--json



Example:



devai status --json



Outputs structured JSON for AI agents, IDEs, and automation tools.



\---



\# 6. Safety and Guardrails



All commands enforce:



\- engine compatibility

\- workspace compatibility

\- AI context compatibility

\- game engine compatibility

\- toolchain validation

\- safe build rules

\- safe generation rules

\- creation guardrails



Commands fail safely with standardized error codes.



\---



\# 7. Extensibility



Engines, workspaces, AI contexts, and game engines can register new commands dynamically.



Examples:



Rust engine:

rust fmt

rust clippy

rust build



Python workspace:

python venv

python lint

python test



Stable Diffusion AI context:

ai train

ai infer

ai profile



Unreal game engine:

game build

game cook

game deploy



\---



\# 8. Summary



cli-commands.md defines the full command surface of the DevAiCoreX CLI. Commands are semantic, context-aware, safe, and extensible. This document is the reference for all CLI behavior and command usage.



