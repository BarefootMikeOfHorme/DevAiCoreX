# DevAiCoreX CLI — Context Cache (Enhanced)

The context cache stores resolved CLI context to speed up routing, validation, and semantic command execution.

## Cache Contents
- engine
- workspace
- aiContext
- gameEngine
- project
- shell
- creationMode
- timestamp

## Cache Location
.devai/context-cache.json

## Cache Behavior
- Updated automatically after context resolution
- Cleared when project structure changes
- Used by build/run/test/deploy/status commands
- Accelerates routing and reduces redundant detection

## Purpose
Improve CLI performance, reduce overhead, and stabilize command flow.
