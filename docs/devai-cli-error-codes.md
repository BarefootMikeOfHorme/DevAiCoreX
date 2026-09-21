\# DevAiCoreX CLI — Error Codes



This document defines standardized error codes for CLI operations. Error codes ensure consistent, machine-friendly error handling.



\---



\# 1. Purpose of Error Codes



Error codes provide:



\- consistent error reporting

\- machine-friendly output

\- safe failure behavior

\- predictable debugging



\---



\# 2. Error Code List



E001 - Unknown command

E002 - Invalid target

E003 - Missing engine

E004 - Missing workspace

E005 - Missing AI context

E006 - Missing game engine

E007 - Toolchain not installed

E008 - Invalid project type

E009 - Guardrail violation

E010 - Routing failure



\---



\# 3. Error Code Behavior



Error codes are returned when:



\- routing fails

\- guardrails fail

\- context is invalid

\- toolchains are missing

\- commands are unknown



\---



\# 4. Machine-Friendly Mode



Error codes appear in:



\--json output



Example:



{

&#x20; "error": "E003",

&#x20; "message": "Missing engine"

}



\---



\# 5. Summary



devai-cli-error-codes.md defines standardized error codes for safe, predictable CLI behavior.



