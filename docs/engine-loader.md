\# Engine Loader  

Engine Detection • Engine Initialization • Engine Metadata • Engine Safety



The Engine Loader is responsible for detecting, initializing, and preparing the correct engine for any DevAiCoreX project. It ensures that all engine metadata, templates, safety rules, and build logic are loaded before any AI generation occurs.



\---



\# 1. Purpose of the Engine Loader



The Engine Loader provides:



\- engine detection

\- engine initialization

\- engine metadata loading

\- engine template loading

\- engine build logic loading

\- engine debug logic loading

\- engine safety rule loading

\- engine compatibility validation



The loader ensures the correct engine is always used.



\---



\# 2. Engine Detection



Engine detection uses:



\- project type

\- workspace metadata

\- lineage metadata

\- engine metadata

\- file structure patterns



Detection rules:



1\. If workspace specifies an engine → use that engine.

2\. If lineage specifies an engine → use that engine.

3\. If project type maps to an engine → use that engine.

4\. If multiple engines match → highest priority engine wins.



\---



\# 3. Engine Initialization



Initialization includes:



\- loading metadata.yaml

\- loading templates/

\- loading build/

\- loading debug/

\- loading ai-context/

\- loading safety rules

\- validating engine version

\- validating engine compatibility



Initialization prepares the engine for generation.



\---



\# 4. Engine Metadata Loading



Metadata is loaded from:



engines/<engine>/metadata.yaml



Metadata includes:



\- engine name

\- engine version

\- supported languages

\- supported profiles

\- safety rules

\- template version

\- build system type



Metadata defines engine behavior.



\---



\# 5. Template Loading



Templates are loaded from:



engines/<engine>/templates/



Templates define:



\- initial project files

\- scaffolding

\- boilerplate

\- engine-specific structures



Templates ensure consistent project creation.



\---



\# 6. Build Logic Loading



Build logic is loaded from:



engines/<engine>/build/



Build logic defines:



\- compiler settings

\- toolchain settings

\- build flags

\- debug flags

\- safety flags



Build logic ensures the project can be compiled.



\---



\# 7. Debug Logic Loading



Debug logic is loaded from:



engines/<engine>/debug/



Debug logic defines:



\- debugging tools

\- debugging flags

\- debugging metadata



Debug logic ensures consistent debugging behavior.



\---



\# 8. Safety Rule Loading



Safety rules are loaded from:



engines/<engine>/ai-context/safety.yaml



Safety rules define:



\- restricted engine operations

\- restricted engine templates

\- restricted build actions



Safety rules override engine behavior when necessary.



\---



\# 9. Summary



The Engine Loader detects, initializes, and prepares the correct engine for DevAiCoreX projects. It ensures consistent, safe, and predictable engine behavior across all project types.



