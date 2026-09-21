\# Workspace Safety  

Restricted Workspace Zones • Workspace Safety Rules • Protected Metadata



Workspace Safety defines all safety constraints specific to DevAiCoreX workspaces. Safety rules override workspace templates, build logic, and generation rules when necessary.



\---



\# 1. Purpose of Workspace Safety



Workspace Safety provides:



\- restricted workspace operations

\- restricted workspace directories

\- restricted file types

\- restricted commands

\- protected metadata files



Workspace Safety prevents unsafe workspace behavior.



\---



\# 2. Restricted Workspace Directories



AI agents may not modify:



\- .devai/workspace.yaml

\- .devai/lineage.yaml

\- .devai/

\- build/

\- venv/

\- cargo/

\- bindings/



These directories contain critical workspace data.



\---



\# 3. Restricted Workspace Operations



AI agents may not:



\- delete workspace metadata

\- modify workspace metadata

\- modify build/debug metadata

\- bypass workspace safety rules

\- generate files outside allowed directories



Restricted operations ensure workspace integrity.



\---



\# 4. Workspace Safety Rules



Workspace safety rules include:



\- enforce restricted directories

\- enforce restricted operations

\- enforce restricted file types

\- enforce restricted commands

\- enforce safety overrides



Workspace safety rules override workspace behavior.



\---



\# 5. Summary



Workspace Safety defines all safety constraints specific to DevAiCoreX workspaces. Safety rules ensure predictable and safe workspace behavior.



