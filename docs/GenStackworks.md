\# GenStackworks  

Engine • Workspace • Build • Prompt Architecture



GenStackworks defines how DevAiCoreX creation engines, workspaces, build systems, and AI‑context prompts interact. It ensures consistent, predictable, safe, and AI‑aware project generation across all languages and profiles. This document explains the GenStackworks architecture and how each component fits together.



\---



\# 1. Purpose of GenStackworks



GenStackworks provides:



\- unified engine structure

\- predictable workspace layout

\- consistent build logic

\- safe, structured AI prompts

\- cross‑engine compatibility

\- cross‑workspace compatibility

\- AI‑aware generation rules



GenStackworks is the backbone of DevAiCoreX creation behavior.



\---



\# 2. GenStackworks Components



GenStackworks is composed of four major components:



\- Engine — defines how a project is created

\- Workspace — defines the folder structure

\- Build — defines how the project is compiled or executed

\- Prompt — defines how AI agents generate content safely



Each component is modular and extendable.



\---



\# 3. Engine Specification



Engines define:



\- templates

\- build logic

\- debug logic

\- AI‑context rules

\- safety rules

\- metadata

\- versioning



\## 3.1 Engine Structure



Folder layout:



engines/<engine-name>/

&#x20;   templates/

&#x20;   build/

&#x20;   debug/

&#x20;   ai-context/

&#x20;   metadata.yaml



\## 3.2 Engine Responsibilities



\- generate initial project files

\- apply templates

\- configure build system

\- configure debug system

\- load AI‑context rules

\- enforce safety rules



\## 3.3 Engine Metadata



metadata.yaml includes:



\- engine name

\- engine version

\- supported languages

\- supported profiles

\- safety rules

\- template version



\---



\# 4. Workspace Specification



Workspaces define the folder layout for each project.



\## 4.1 Workspace Structure



Folder layout:



src/

include/

cargo/

venv/

bindings/

api/

.devai/



\## 4.2 Workspace Responsibilities



\- provide predictable folder layout

\- provide build/debug file locations

\- provide metadata for AI agents

\- provide lineage storage

\- enforce profile rules



\## 4.3 Workspace Metadata



Stored in:



.devai/workspace.yaml



Contains:



\- workspace type

\- workspace version

\- folder structure

\- build/debug metadata

\- profile metadata



\---



\# 5. Build Specification



Build logic defines how projects are compiled or executed.



\## 5.1 Build Structure



Folder layout:



build/

&#x20;   build.ps1

&#x20;   build.sh

&#x20;   build.json



\## 5.2 Build Responsibilities



\- compile code

\- run code

\- validate toolchains

\- enforce safety rules

\- provide build metadata



\## 5.3 Build Metadata



Includes:



\- compiler version

\- toolchain version

\- build flags

\- safety flags

\- output paths



\---



\# 6. Prompt Specification



Prompts define how AI agents generate content safely.



\## 6.1 Prompt Structure



Location:



ai-context/prompts/<engine>/<topic>.md



\## 6.2 Prompt Responsibilities



\- enforce safe generation

\- enforce correct engine usage

\- enforce correct workspace usage

\- enforce profile rules

\- provide structured generation templates



\## 6.3 Prompt Metadata



Includes:



\- prompt type

\- safety rules

\- lineage rules

\- memory rules

\- engine compatibility



\---



\# 7. GenStackworks Flow



1\. DevCShell detects project type

2\. Engine loads

3\. Workspace generates

4\. Build system configures

5\. Prompts load

6\. AI‑context applies

7\. Lineage records creation



This ensures predictable, safe, AI‑augmented creation.



\---



\# 8. Extensibility



Custom engines:

engines/custom/<engine-name>



Custom workspaces:

workspaces/custom/<workspace-name>



Custom build systems:

engines/<engine>/build/custom/



Custom prompts:

ai-context/prompts/custom/



\---



\# 9. Summary



GenStackworks defines how engines, workspaces, build systems, and AI prompts interact inside DevAiCoreX. It ensures safe, predictable, structured, and AI‑aware project creation across all languages and profiles.



