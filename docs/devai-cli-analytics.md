\# DevAiCoreX CLI — Analytics System



This document defines the CLI analytics system. Analytics track command usage locally to improve user experience and debugging.



\---



\# 1. Purpose of Analytics



Analytics track:



\- command usage

\- subcommand usage

\- engine usage

\- workspace usage

\- AI context usage

\- game engine usage



Analytics are stored locally only.



\---



\# 2. Analytics Storage



Analytics are stored in:



analytics.json



Stored values include:



command name

usage count



\---



\# 3. Analytics Behavior



Analytics update when:



\- a command is executed

\- a subcommand is executed

\- a handler runs



Analytics do NOT:



\- transmit data externally

\- store sensitive information



\---



\# 4. Analytics Usage



Analytics help:



\- debugging

\- optimization

\- user experience improvements



\---



\# 5. Summary



devai-cli-analytics.md defines the analytics system for tracking CLI usage locally.



