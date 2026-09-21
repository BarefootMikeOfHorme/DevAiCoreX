\# Workspace Types  

Standard Workspace • Cargo Workspace • Venv Workspace • Hybrid Workspace



Workspace Types define the folder layout, metadata structure, and generation rules for DevAiCoreX projects. Each workspace type provides a predictable environment for engines, build systems, and AI agents.



\---



\# 1. Purpose of Workspace Types



Workspace types provide:



\- consistent folder structure

\- predictable file locations

\- metadata organization

\- build/debug integration

\- safety boundaries

\- engine compatibility



Workspace types ensure stable project environments.



\---



\# 2. Standard Workspace



Folder layout:



src/

include/

.devai/

build/

api/



Used for:



\- C/C++

\- Rust hybrid

\- Python hybrid

\- mixed-language projects



\---



\# 3. Cargo Workspace



Folder layout:



src/

Cargo.toml

target/

.devai/



Used for:



\- Rust-only projects

\- Rust-first hybrid projects



\---



\# 4. Venv Workspace



Folder layout:



src/

venv/

requirements.txt

.devai/



Used for:



\- Python-only projects

\- Python-first hybrid projects



\---



\# 5. Hybrid Workspace



Folder layout:



src/

cargo/

venv/

bindings/

.devai/



Used for:



\- Rust + Python bindings

\- mixed-language engines

\- advanced AI-driven builds



\---



\# 6. Summary



Workspace Types define the structure and behavior of DevAiCoreX project environments. They ensure predictable, safe, and engine-compatible layouts.



