\# Creation Safety  

Safety Enforcement • Restricted Creation Zones • Protected Metadata



Creation Safety defines all safety constraints applied during project creation. Safety rules override engine templates, workspace structure, and build logic when necessary.



\---



\# 1. Purpose of Creation Safety



Creation Safety provides:



\- restricted creation operations

\- restricted creation directories

\- restricted template usage

\- restricted build initialization

\- protected metadata files



Safety ensures project creation cannot damage the system.



\---



\# 2. Restricted Creation Directories



AI agents may not modify:



\- .devai/

\- engines/

\- build/

\- venv/

\- cargo/

\- bindings/



These directories contain critical project data.



\---



\# 3. Restricted Creation Operations



AI agents may not:



\- delete metadata

\- modify metadata

\- bypass safety rules

\- generate files outside allowed directories

\- modify engine/workspace/build metadata



Restricted operations ensure safe creation.



\---



\# 4. Creation Safety Rules



Safety rules include:



\- enforce restricted directories

\- enforce restricted operations

\- enforce restricted file types

\- enforce restricted commands

\- enforce safety overrides



Safety rules override creation behavior.



\---



\# 5. Summary



Creation Safety defines all safety constraints applied during project creation. Safety ensures predictable and safe initialization.



