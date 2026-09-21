\# Engine Profiles  

Generation Profiles • Safety Profiles • Compatibility Profiles



Engine Profiles define how engines behave under different generation modes, safety levels, and project types. Profiles modify engine behavior without changing engine metadata or templates.



\---



\# 1. Purpose of Engine Profiles



Engine Profiles provide:



\- generation style control

\- safety level control

\- engine compatibility control

\- workspace compatibility control

\- build compatibility control

\- prompt compatibility control



Profiles allow engines to adapt to different project needs.



\---



\# 2. Profile Types



Profile types include:



\- Standard

\- Safe

\- Strict

\- Experimental

\- Minimal

\- Full



Each profile modifies engine behavior.



\---



\# 3. Profile Metadata



Profile metadata is stored in:



ai-context/profiles/<profile>.yaml



Metadata includes:



\- profile name

\- profile version

\- safety level

\- engine compatibility

\- workspace compatibility

\- build compatibility

\- prompt compatibility



Profiles modify the final AI context.



\---



\# 4. Profile Effects on Engines



Profiles may modify:



\- template selection

\- build flags

\- debug flags

\- safety rules

\- generation rules

\- memory rules

\- prompt rules



Profiles override engine defaults when necessary.



\---



\# 5. Profile Enforcement



Profile enforcement occurs after:



\- engine metadata loading

\- workspace metadata loading

\- build metadata loading

\- safety metadata loading



Profiles modify the final merged context.



\---



\# 6. Summary



Engine Profiles define how engines behave under different generation modes, safety levels, and compatibility constraints. Profiles ensure flexible and safe engine behavior.



