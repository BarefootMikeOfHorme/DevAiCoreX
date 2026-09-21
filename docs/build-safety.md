\# Build Safety  

Restricted Build Actions • Protected Build Zones • Build Safety Rules



Build Safety defines all safety constraints specific to DevAiCoreX build systems. Safety rules override compiler logic, toolchain logic, and build flags when necessary.



\---



\# 1. Purpose of Build Safety



Build Safety provides:



\- restricted build operations

\- restricted build directories

\- restricted build flags

\- restricted toolchain actions

\- protected build metadata

\- protected output directories



Build Safety prevents unsafe or destructive builds.



\---



\# 2. Restricted Build Directories



AI agents may not modify:



\- build/build.json

\- build/build.ps1

\- build/build.sh

\- build/output/

\- build/temp/



These directories contain critical build data.



\---



\# 3. Restricted Build Operations



AI agents may not:



\- delete build metadata

\- modify build metadata

\- modify compiler configuration

\- modify toolchain configuration

\- bypass build safety rules

\- generate files outside allowed build paths



Restricted operations ensure build integrity.



\---



\# 4. Build Safety Rules



Build safety rules include:



\- enforce restricted directories

\- enforce restricted operations

\- enforce restricted flags

\- enforce restricted commands

\- enforce safety overrides



Build safety rules override build behavior.



\---



\# 5. Summary



Build Safety defines all safety constraints specific to DevAiCoreX build systems. Safety rules ensure predictable and safe build behavior.



