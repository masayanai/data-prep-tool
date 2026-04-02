---
name: refactor-audit
description: Validate that REFACTOR phase introduces no behavioral changes and preserves determinism.
---

# Trigger Conditions

- **Phase**: GREEN → REFACTOR transition
- **When**: Current TDD phase is REFACTOR and the working diff contains production code changes with no test behavior changes
- **Who**: All agents (Claude, Codex, Cursor, Antigravity)
- **Signal**: During self-review of REFACTOR changes (before staging/committing); after GREEN tests are confirmed passing

# Procedure

## 1. Behavior Preservation
- Any change in outputs?
- Any change in test expectations?

## 2. Structural Improvements
- Naming clarity improved?
- Duplication reduced?
- Readability improved?

## 3. Risk Detection
- Hidden logic changes?
- Control flow differences?

## 4. Determinism Check
- Replay behavior unchanged?
- No new implicit state?

# Output Format

## Behavior Change Detected (YES / NO)
## Structural Improvements
## Risks
## Decision (SAFE / UNSAFE)

# Guardrails
- Behavior must remain identical
- Flag even subtle semantic shifts

# Violation Examples

- ❌ Changed a method signature and updated all callers (behavioral change, not pure refactor)
- ❌ Replaced a dict lookup with a method that adds caching (introduces implicit state)
- ❌ Reordered event processing steps in a way that changes evaluation order
- ❌ Renamed a public API field that external consumers depend on
- ❌ "Simplified" a conditional branch that actually removed an edge-case handling path
