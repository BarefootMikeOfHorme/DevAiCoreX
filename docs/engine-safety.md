\# Engine Safety  

Engine Restrictions • Protected Engine Zones • Engine Safety Rules



Engine Safety defines all safety constraints specific to DevAiCoreX engines. Engine safety rules override engine templates, build logic, and debug logic when necessary.



\---



\# 1. Purpose of Engine Safety



Engine Safety provides:



\- restricted engine operations

\- restricted engine templates

\- restricted build actions

\- restricted debug actions

\- protected engine metadata

\- protected engine directories



Engine Safety prevents unsafe engine behavior.



\---



\# 2. Restricted Engine Directories



AI agents may not modify:



\- engines/<engine>/metadata.yaml

\- engines/<engine>/templates/

\- engines/<engine>/build/

\- engines/<engine>/debug/

\- engines/<engine>/ai-context/



These directories contain critical engine data.



\---



\# 3. Restricted Engine Operations



AI agents may not:



\- delete engine templates

\- modify engine metadata

\- modify build logic

\- modify debug logic

\- bypass engine safety rules



Restricted operations ensure engine integrity.



\---



\# 4. Engine Safety Rules



Engine safety rules include:



\- enforce restricted directories

\- enforce restricted operations

\- enforce restricted file types

\- enforce restricted commands

\- enforce safety overrides



Engine safety rules override engine behavior.



\---



\# 5. Summary



Engine Safety defines all safety constraints specific to DevAiCoreX engines. Safety rules ensure engines behave predictably and safely.



