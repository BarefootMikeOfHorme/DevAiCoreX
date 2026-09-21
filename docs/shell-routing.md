\# Shell Routing  

DevCShell Routing • WPShell Routing • Engine Routing • Workspace Routing



Shell Routing defines how DevAiCoreX determines which shell (DevCShell or WPShell) should handle a command. Routing ensures commands are executed in the correct context.



\---



\# 1. Purpose of Shell Routing



Shell Routing provides:



\- command classification

\- shell selection

\- engine-aware routing

\- workspace-aware routing

\- build-aware routing

\- safety-aware routing



Routing ensures commands reach the correct subsystem.



\---



\# 2. Routing Rules



Routing rules include:



DevCShell handles:

\- project creation

\- engine selection

\- workspace selection

\- global metadata

\- global safety



WPShell handles:

\- workspace operations

\- build operations

\- local metadata

\- local safety



\---



\# 3. Routing Flow



1\. Parse command  

2\. Identify command category  

3\. Check engine/workspace context  

4\. Apply safety rules  

5\. Route to DevCShell or WPShell  

6\. Execute command  



Routing ensures predictable command behavior.



\---



\# 4. Safety Routing



Safety routing ensures:



\- unsafe commands are blocked

\- restricted directories are protected

\- restricted operations are denied

\- safety overrides apply before routing



Safety routing prevents destructive behavior.



\---



\# 5. Summary



Shell Routing ensures DevAiCoreX commands are executed by the correct shell. Routing provides safe, predictable command behavior across all project types.



