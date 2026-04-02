---
name: slice-design-review
description: Review a vertical slice design for scope correctness, architectural compliance, determinism, and TDD readiness.
---

# Trigger Conditions

- **Phase**: Before RED implementation
- **When**: A new `vertical_slice_XX.md` is created or revised
- **Who**: All agents (Claude, Codex, Cursor, Antigravity)
- **Signal**: Human requests "review this slice" or agent begins work on a new slice

# Inputs

- Slice document (`docs/platform/slices/vertical_slice_XX.md`)
- Roadmap
- Architecture principles / ADRs
- Context snapshot (`docs/ai/CONTEXT_SNAPSHOT_latest.md`)

# Procedure

## 1. Responsibility
Summarize slice responsibility in 3–6 lines.

## 2. Must NOT Do
Explicitly list:
- Future slice responsibilities
- Forbidden side effects
- Boundary violations

## 3. Scope Leakage Check
- Any future slice logic included?
- Any cross-boundary dependency?

## 4. Determinism Check
- Any implicit state?
- Any time-based behavior?
- Any non-replayable logic?

## 5. TDD Readiness
- Can RED tests be defined clearly?
- Are inputs/outputs well-defined?

## 6. Gaps / Risks
- Missing contracts
- Naming inconsistencies
- Ambiguous boundaries

# Output Format

## Responsibility
## Must NOT Do
## Risks
## TDD Readiness
## Decision (APPROVE / BLOCK)
## Next Action

# Guardrails
- Prefer narrower interpretation
- Do not invent architecture
- Separate blocking vs optional

# Violation Examples

- ❌ Slice document includes responsibilities from a future slice (e.g., Slice 09 doc defines notification routing that belongs to Slice 10)
- ❌ Slice defines direct external API calls instead of delegating to n8n
- ❌ Inputs/outputs are ambiguous enough that RED tests cannot be written deterministically
- ❌ Slice assumes implicit ordering from a component not yet implemented
