\# Engine Metadata  

Metadata Structure • Metadata Rules • Metadata Enforcement



Engine Metadata defines the configuration, capabilities, and constraints of each DevAiCoreX engine. Metadata ensures consistent engine behavior across all project types.



\---



\# 1. Purpose of Engine Metadata



Engine metadata provides:



\- engine identification

\- engine versioning

\- supported languages

\- supported profiles

\- safety rules

\- template version

\- build system type

\- engine capabilities



Metadata defines engine behavior.



\---



\# 2. Metadata Structure



Metadata is stored in:



engines/<engine>/metadata.yaml



Fields include:



engine:

&#x20;   name: <string>

&#x20;   version: <string>

&#x20;   languages: <list>

&#x20;   profiles: <list>

&#x20;   safety: <list>

&#x20;   template\_version: <string>

&#x20;   build\_system: <string>



\---



\# 3. Metadata Rules



Metadata rules include:



\- engine name must be unique

\- engine version must follow semantic versioning

\- supported languages must be valid

\- supported profiles must exist

\- safety rules must be valid

\- template version must match templates/



Metadata rules ensure consistency.



\---



\# 4. Metadata Enforcement



Metadata enforcement occurs during:



\- engine detection

\- engine initialization

\- template loading

\- build logic loading

\- safety rule loading



Metadata overrides engine defaults.



\---



\# 5. Summary



Engine Metadata defines the configuration and capabilities of each DevAiCoreX engine. Metadata ensures consistent, predictable engine behavior.



