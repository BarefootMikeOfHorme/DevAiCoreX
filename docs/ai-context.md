\# AI Context System  

DevAiCoreX Context Loading • Engine Awareness • Workspace Awareness • Safety Integration



The AI Context System defines how DevAiCoreX loads, merges, and applies contextual metadata to AI agents during project creation, modification, and analysis. It ensures that every AI operation is aware of the engine, workspace, build system, safety rules, lineage, and project type.



\---



\# 1. Purpose of the AI Context System



The AI Context System provides:



\- unified context loading for all AI agents

\- engine-aware generation rules

\- workspace-aware generation rules

\- build-aware generation rules

\- safety-aware generation rules

\- lineage-aware generation rules

\- profile-aware generation rules

\- project-type-aware generation rules



AI Context ensures that every generation step is consistent, safe, and aligned with DevAiCoreX architecture.



\---



\# 2. AI Context Components



The AI Context System is composed of:



\- Context Loader

\- Context Metadata

\- Context Merge Engine

\- Context Safety Layer

\- Context Lineage Layer

\- Context Profiles

\- Context Prompts



Each component contributes to the final AI context applied to generation.



\---



\# 3. Context Loader



The Context Loader is responsible for:



\- detecting project type

\- loading engine metadata

\- loading workspace metadata

\- loading build metadata

\- loading lineage metadata

\- loading safety metadata

\- loading profile metadata

\- loading prompt metadata



The loader merges all metadata into a unified context object.



\---



\# 4. Context Metadata Structure



Context metadata is stored across multiple files:



Engine metadata:

engines/<engine>/metadata.yaml



Workspace metadata:

.devai/workspace.yaml



Lineage metadata:

.devai/lineage.yaml



Build metadata:

build/build.json



Prompt metadata:

ai-context/prompts/<engine>/<topic>.md



Safety metadata:

ai-context/safety.yaml



Profile metadata:

ai-context/profiles/<profile>.yaml



\---



\# 5. Context Merge Engine



The merge engine combines metadata from:



\- engine

\- workspace

\- build system

\- lineage

\- safety rules

\- profiles

\- prompts



Merge rules:



1\. Engine metadata overrides workspace defaults.

2\. Workspace metadata overrides build defaults.

3\. Safety metadata overrides all conflicting fields.

4\. Lineage metadata appends, never replaces.

5\. Profile metadata injects additional constraints.

6\. Prompt metadata defines generation behavior.



The final result is a unified context object.



\---



\# 6. Context Safety Layer



The safety layer enforces:



\- restricted generation zones

\- restricted file types

\- restricted engine operations

\- restricted workspace operations

\- restricted build operations

\- restricted prompt operations

\- restricted memory operations



Safety rules are loaded from:



ai-context/safety.yaml



Safety rules apply before any generation occurs.



\---



\# 7. Context Lineage Layer



The lineage layer ensures:



\- all generation is recorded

\- all engine operations are tracked

\- all workspace changes are tracked

\- all build changes are tracked

\- all AI-generated content is tracked

\- all metadata changes are tracked



Lineage is append-only and stored in:



.devai/lineage.yaml



\---



\# 8. Context Profiles



Profiles define:



\- generation style

\- safety level

\- engine compatibility

\- workspace compatibility

\- build compatibility

\- prompt compatibility



Profiles are stored in:



ai-context/profiles/<profile>.yaml



Profiles modify the final context object.



\---



\# 9. Context Prompts



Prompts define:



\- generation templates

\- safety instructions

\- engine-specific rules

\- workspace-specific rules

\- build-specific rules

\- lineage rules

\- memory rules



Prompts are stored in:



ai-context/prompts/<engine>/<topic>.md



Prompts are loaded after metadata and before safety enforcement.



\---



\# 10. Context Application Flow



1\. Detect project type

2\. Load engine metadata

3\. Load workspace metadata

4\. Load build metadata

5\. Load lineage metadata

6\. Load safety metadata

7\. Load profile metadata

8\. Load prompt metadata

9\. Merge metadata into unified context

10\. Apply safety layer

11\. Apply lineage layer

12\. Apply profile rules

13\. Apply prompt rules

14\. Begin generation



This ensures safe, predictable, engine-aware generation.



\---



\# 11. Summary



The AI Context System provides unified, safe, engine-aware, workspace-aware, build-aware, lineage-aware, and profile-aware metadata for all AI operations inside DevAiCoreX. It ensures consistent, predictable, and safe generation across all engines, workspaces, and project types.



