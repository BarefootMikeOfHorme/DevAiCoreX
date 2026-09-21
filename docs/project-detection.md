\# Project Detection  

Automatic Detection • Engine Mapping • Workspace Mapping • Build Mapping



Project Detection determines which engine, workspace, and build system DevAiCoreX should use when a project is created or loaded. Detection ensures correct subsystem selection without manual configuration.



\---



\# 1. Purpose of Project Detection



Project detection provides:



\- automatic engine selection

\- automatic workspace selection

\- automatic build system selection

\- metadata-based detection

\- structure-based detection

\- lineage-based detection



Detection ensures correct project initialization.



\---



\# 2. Detection Sources



Detection uses:



\- folder structure

\- workspace.yaml

\- lineage.yaml

\- engine metadata

\- build metadata

\- file patterns



Multiple sources ensure accurate detection.



\---



\# 3. Detection Rules



Rules include:



1\. If workspace.yaml specifies a type → use that type.

2\. If lineage.yaml specifies an engine → use that engine.

3\. If folder structure matches a known workspace → use that workspace.

4\. If file patterns match a known engine → use that engine.

5\. If multiple engines match → highest priority engine wins.



Rules ensure deterministic behavior.



\---



\# 4. Engine Mapping



Engine mapping uses:



\- language detection

\- file extension detection

\- template detection

\- metadata detection



Mapping ensures correct engine selection.



\---



\# 5. Workspace Mapping



Workspace mapping uses:



\- folder structure

\- metadata

\- lineage

\- engine requirements



Mapping ensures correct workspace selection.



\---



\# 6. Build Mapping



Build mapping uses:



\- build.json

\- toolchain detection

\- engine requirements

\- workspace requirements



Mapping ensures correct build system selection.



\---



\# 7. Summary



Project Detection ensures DevAiCoreX selects the correct engine, workspace, and build system automatically. Detection provides safe, predictable initialization.



