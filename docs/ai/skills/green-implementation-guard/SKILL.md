---
name: green-implementation-guard
description: Ensure GREEN implementation stays minimal, does not expand scope, and strictly follows TDD.
---

# Trigger Conditions

- **Phase**: GREEN (implementation)
- **When**: Current TDD phase is GREEN and the working diff contains production code changes
- **Who**: All agents (Claude, Codex, Cursor, Antigravity)
- **Signal**: During self-review of GREEN implementation (before staging/committing); when human requests GREEN review

# Procedure

## 1. Test Alignment
- Does implementation match failing test exactly?
- Any extra behavior added?

## 2. Scope Control
- Any future slice logic included?
- Any speculative abstraction?

## 3. Minimality Check
- Smallest change to pass tests?
- Any unnecessary generalization?

## 4. Boundary Enforcement
- Domain boundaries preserved?
- Any leakage across modules?

## 5. Side Effects
- Any hidden or implicit effects?

# Output Format

## Violations
## Risk Level (LOW / MEDIUM / HIGH)
## Required Fixes
## Safe to Proceed (YES / NO)

# Guardrails
- Minimal solution only
- No future-proofing
- No architecture expansion

# Violation Examples

- ❌ Added a utility function not required by any current test
- ❌ Introduced an abstract base class "for future extensibility" when only one implementation exists
- ❌ Modified an existing test assertion to make it pass instead of fixing the implementation
- ❌ Imported a module from a future slice's namespace
- ❌ Added error handling for scenarios not covered by any current test
