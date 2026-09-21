\# AI Safety System  

Safety Rules • Restricted Operations • Protected Zones • Enforcement Layers



The AI Safety System defines all safety constraints that DevAiCoreX AI agents must obey during project creation, modification, analysis, and generation. Safety rules override all other systems, including engine rules, workspace rules, build rules, memory rules, and prompt rules.



\---



\# 1. Purpose of the AI Safety System



The AI Safety System provides:



\- strict protection of project structure

\- strict protection of metadata files

\- strict protection of lineage history

\- strict protection of engine/workspace/build systems

\- restricted generation zones

\- restricted file types

\- restricted operations

\- restricted commands

\- safety overrides for all rule categories



Safety ensures that AI agents cannot damage the project or violate architectural constraints.



\---



\# 2. Safety Enforcement Layers



Safety is enforced across multiple layers:



\- Engine Safety Layer

\- Workspace Safety Layer

\- Build Safety Layer

\- Lineage Safety Layer

\- Memory Safety Layer

\- Prompt Safety Layer



Each layer contributes to the final safety envelope applied to AI operations.



\---



\# 3. Restricted Directories



AI agents may not generate, modify, or delete files in:



\- .devai/

\- .devai/workspace.yaml

\- .devai/lineage.yaml

\- engines/<engine>/metadata.yaml

\- engines/<engine>/ai-context/

\- build/build.json

\- build/build.ps1

\- build/build.sh



These directories contain critical metadata and must remain intact.



\---



\# 4. Restricted File Types



AI agents may not generate or modify:



\- executable binaries

\- compiled objects

\- system-level scripts

\- destructive shell commands

\- unsafe configuration files

\- files outside the project root



Restricted file types prevent accidental system-level damage.



\---



\# 5. Restricted Operations



AI agents may not perform:



\- deletion of project files

\- deletion of metadata files

\- deletion of lineage history

\- modification of safety rules

\- modification of engine/workspace/build metadata

\- execution of unsafe commands

\- bypassing safety layers

\- generating content outside allowed directories



Restricted operations ensure project integrity.



\---



\# 6. Safety Overrides



Safety overrides all other rule categories:



\- engine rules

\- workspace rules

\- build rules

\- lineage rules

\- memory rules

\- prompt rules

\- profile rules



If any rule conflicts with safety, safety wins.



\---



\# 7. Safety Metadata



Safety metadata is stored in:



ai-context/safety.yaml



Safety metadata defines:



\- restricted directories

\- restricted file types

\- restricted operations

\- restricted commands

\- safety flags

\- safety levels



Safety metadata is loaded before any generation occurs.



\---



\# 8. Safety Levels



Safety levels define how strict the safety system is:



Level 1: Basic protection  

Level 2: Engine-aware protection  

Level 3: Workspace-aware protection  

Level 4: Build-aware protection  

Level 5: Full protection (default)



Higher levels enforce stricter constraints.



\---



\# 9. Safety Enforcement Flow



1\. Load safety metadata

2\. Load restricted directories

3\. Load restricted file types

4\. Load restricted operations

5\. Load restricted commands

6\. Apply safety overrides

7\. Apply engine/workspace/build constraints

8\. Apply lineage protection

9\. Apply memory protection

10\. Apply prompt protection

11\. Begin generation



Safety is applied before any AI operation.



\---



\# 10. Safety Command Restrictions



AI agents may not execute:



\- destructive PowerShell commands

\- destructive Bash commands

\- system-level commands

\- commands that modify the OS

\- commands that modify external directories

\- commands that bypass project boundaries



Command restrictions prevent accidental system damage.



\---



\# 11. Safety Generation Rules



AI agents must:



\- generate only inside allowed directories

\- generate only allowed file types

\- follow engine/workspace/build safety rules

\- follow prompt safety rules

\- follow memory safety rules

\- follow lineage safety rules



Safety generation rules ensure predictable behavior.



\---



\# 12. Summary



The AI Safety System provides strict protection for all AI operations inside DevAiCoreX. Safety overrides all other rule categories and ensures that AI agents cannot damage the project, violate metadata constraints, or bypass architectural rules.



