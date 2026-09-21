\# DevAiCoreX CLI — Creation Station Mode



This document defines Creation Station mode, the DevAiCoreX environment for generating engines, workspaces, AI contexts, game engines, and full projects. Creation Station mode is intelligent, safe, and template-driven.



\---



\# 1. Purpose of Creation Station



Creation Station mode enables:



\- engine creation

\- workspace creation

\- AI context creation

\- game engine creation

\- project creation



It provides:



\- templates

\- guardrails

\- lineage

\- metadata

\- safe generation rules



\---



\# 2. Activation



Creation Station mode activates when:



devcshell launches

devai create <target> is used

creation templates are loaded

creation guardrails are required



\---



\# 3. Creation Targets



Supported creation targets:



engine

workspace

ai

game

project



Examples:



devai create engine rust

devai create workspace python

devai create ai stable-diffusion

devai create game unreal

devai create project converter



\---



\# 4. Creation Components



Creation Station uses:



creation templates

creation guardrails

creation metadata

creation lineage

creation toolchains



These ensure safe, predictable generation.



\---



\# 5. Creation Templates



Templates define:



\- folder structure

\- initial files

\- metadata

\- build logic

\- debug logic

\- AI rules



Templates are stored in:



engines/<engine>/templates/

workspaces/<workspace>/templates/

ai-context/prompts/<engine>/

game-engines/<engine>/templates/



\---



\# 6. Creation Guardrails



Guardrails prevent:



\- invalid engine creation

\- invalid workspace creation

\- invalid AI context creation

\- invalid game engine creation

\- unsafe project generation



Guardrails enforce:



\- compatibility

\- safety rules

\- metadata rules

\- toolchain rules



\---



\# 7. Creation Lineage



Creation Station records:



\- creation steps

\- template versions

\- engine versions

\- workspace versions

\- AI context versions



Lineage is stored in:



.devai/lineage/



\---



\# 8. Creation Metadata



Creation metadata includes:



\- creation type

\- creation version

\- template version

\- engine/workspace/AI/game metadata



Metadata ensures reproducible generation.



\---



\# 9. Summary



cli-creation-station.md defines Creation Station mode, enabling safe, structured generation of engines, workspaces, AI contexts, game engines, and full projects.



