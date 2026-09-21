\# Build Debug System  

Debug Flags • Debug Tools • Debug Metadata • Debug Safety



The Build Debug System defines how DevAiCoreX projects are debugged during compilation and execution. Debug rules ensure safe, predictable, and engine-aware debugging behavior.



\---



\# 1. Purpose of Build Debug



Build Debug provides:



\- debug flag management

\- debug tool configuration

\- debug metadata loading

\- debug safety enforcement

\- engine/workspace/build integration



Debug ensures safe troubleshooting across all engines.



\---



\# 2. Debug Flags



Debug flags include:



\- debug symbols

\- debug output

\- debug metadata

\- debug safety flags

\- debug optimization overrides



Flags modify how compilers and toolchains behave during debugging.



\---



\# 3. Debug Tools



Debug tools include:



\- Rust debugger (cargo debug, rust-gdb)

\- Python debugger (pdb, debugpy)

\- C/C++ debugger (gdb, lldb)

\- hybrid debuggers (Rust/Python bindings)

\- engine-specific debug adapters



Tools ensure engine compatibility and safe execution.



\---



\# 4. Debug Metadata



Metadata is stored in:



build/build.json



Metadata includes:



debug:

&#x20;   flags: <list>

&#x20;   tools: <list>

&#x20;   safety: <list>

&#x20;   output: <string>



Metadata defines how debugging is configured and executed.



\---



\# 5. Debug Safety



Debug safety rules include:



\- restricted debug commands

\- restricted debug operations

\- restricted debug directories

\- restricted memory inspection

\- restricted external process attachment



Safety prevents unsafe or destructive debugging behavior.



\---



\# 6. Debug Boundaries



Debug boundaries include:



\- project root

\- workspace directories

\- engine directories

\- build directories



Debugging cannot access external system paths.



\---



\# 7. Debug Flow



1\. Load build metadata  

2\. Load debug flags  

3\. Load debug tools  

4\. Apply safety rules  

5\. Initialize engine debug adapter  

6\. Execute debug session  

7\. Log debug events  

8\. Update lineage  



Debug flow ensures predictable and traceable debugging.



\---



\# 8. Summary



The Build Debug System defines safe, predictable debugging behavior for DevAiCoreX projects. It ensures engine-aware, workspace-aware, and safety-aware debugging across all project types.



