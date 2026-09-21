\# Workspace Loader  

Workspace Detection • Workspace Initialization • Workspace Metadata



The Workspace Loader detects, initializes, and prepares the correct workspace type for DevAiCoreX projects. It ensures consistent folder structure, metadata loading, and safety enforcement.



\---



\# 1. Purpose of the Workspace Loader



The Workspace Loader provides:



\- workspace detection

\- workspace initialization

\- workspace metadata loading

\- workspace safety rule loading

\- workspace compatibility validation



The loader ensures the correct workspace is always used.



\---



\# 2. Workspace Detection



Workspace detection uses:



\- folder structure

\- workspace metadata

\- lineage metadata

\- project type

\- engine metadata



Detection rules:



1\. If workspace.yaml specifies a type → use that type.

2\. If lineage specifies a workspace → use that type.

3\. If folder structure matches a workspace → use that type.



\---



\# 3. Workspace Initialization



Initialization includes:



\- loading .devai/workspace.yaml

\- validating folder structure

\- validating workspace version

\- loading workspace safety rules

\- loading workspace metadata



Initialization prepares the workspace for generation.



\---



\# 4. Workspace Metadata



Metadata is stored in:



.devai/workspace.yaml



Metadata includes:



\- workspace type

\- workspace version

\- folder structure

\- build/debug metadata

\- profile metadata



Metadata defines workspace behavior.



\---



\# 5. Workspace Safety Rules



Workspace safety rules include:



\- restricted directories

\- restricted file types

\- restricted operations

\- restricted commands



Workspace safety rules override workspace behavior.



\---



\# 6. Summary



The Workspace Loader detects, initializes, and prepares the correct workspace type for DevAiCoreX projects. It ensures consistent, safe, and predictable workspace behavior.



