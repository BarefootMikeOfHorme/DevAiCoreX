\# DevAiCoreX CLI — Context Cache



This document defines the CLI context cache system. The context cache stores resolved context to speed up repeated commands and reduce redundant detection.



\---



\# 1. Purpose of Context Cache



The context cache stores:



\- engine

\- workspace

\- AI context

\- game engine

\- project type

\- shell mode

\- Creation Station mode

\- timestamp



Caching improves performance and reduces repeated detection.



\---



\# 2. Cache Structure



The cache stores:



project

engine

workspace

aiContext

gameEngine

shell

timestamp



\---



\# 3. Cache Behavior



Cache updates when:



\- context changes

\- project changes

\- engine changes

\- workspace changes

\- AI context changes

\- game engine changes

\- shell mode changes



Cache is cleared when:



\- project changes

\- guardrails fail

\- invalid context is detected



\---



\# 4. Cache Usage



Cache is used by:



devai-context-resolver.ps1

devai-command-router.ps1

devai-cli-output.ps1

devai-cli-guardrails.ps1



Cache enables semantic commands like:



devai build

devai run

devai test



to resolve instantly.



\---



\# 5. Summary



devai-cli-context-cache.md defines the context cache system, enabling fast, efficient CLI behavior.



