\# Workspace Metadata  

Metadata Structure • Workspace Rules • Workspace Capabilities



Workspace Metadata defines the configuration, capabilities, and constraints of each DevAiCoreX workspace. Metadata ensures consistent workspace behavior across all project types.



\---



\# 1. Purpose of Workspace Metadata



Workspace metadata provides:



\- workspace identification

\- workspace versioning

\- folder structure definition

\- build/debug metadata

\- profile metadata

\- safety metadata



Metadata defines workspace behavior.



\---



\# 2. Metadata Structure



Metadata is stored in:



.devai/workspace.yaml



Fields include:



workspace:

&#x20;   type: <string>

&#x20;   version: <string>

&#x20;   folders: <list>

&#x20;   build: <map>

&#x20;   debug: <map>

&#x20;   profiles: <list>

&#x20;   safety: <list>



\---



\# 3. Metadata Rules



Metadata rules include:



\- workspace type must be valid

\- workspace version must follow semantic versioning

\- folder structure must match actual directories

\- build/debug metadata must be valid

\- safety rules must be valid



Metadata rules ensure consistency.



\---



\# 4. Metadata Enforcement



Metadata enforcement occurs during:



\- workspace detection

\- workspace initialization

\- build system loading

\- safety rule loading



Metadata overrides workspace defaults.



\---



\# 5. Summary



Workspace Metadata defines the configuration and capabilities of each DevAiCoreX workspace. Metadata ensures consistent, predictable workspace behavior.



