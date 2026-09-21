\# Prompt Safety  

Restricted Prompt Zones • Prompt Safety Rules • Protected Prompt Metadata



Prompt Safety defines all safety constraints specific to DevAiCoreX prompt templates. Safety rules override prompt templates when necessary.



\---



\# 1. Purpose of Prompt Safety



Prompt Safety provides:



\- restricted prompt operations

\- restricted prompt templates

\- restricted prompt metadata

\- protected prompt directories

\- safety overrides for prompts



Prompt Safety prevents unsafe generation.



\---



\# 2. Restricted Prompt Directories



AI agents may not modify:



\- ai-context/prompts/<engine>/

\- ai-context/prompts/custom/

\- ai-context/safety.yaml



These directories contain critical prompt data.



\---



\# 3. Restricted Prompt Operations



AI agents may not:



\- delete prompt templates

\- modify prompt templates

\- modify safety templates

\- bypass prompt safety rules

\- generate content outside allowed prompt boundaries



Restricted operations ensure prompt integrity.



\---



\# 4. Prompt Safety Rules



Prompt safety rules include:



\- enforce restricted directories

\- enforce restricted operations

\- enforce restricted file types

\- enforce restricted commands

\- enforce safety overrides



Prompt safety rules override prompt behavior.



\---



\# 5. Summary



Prompt Safety defines all safety constraints specific to DevAiCoreX prompt templates. Safety rules ensure predictable and safe generation.



