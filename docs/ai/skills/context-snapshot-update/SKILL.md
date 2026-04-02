---
name: context-snapshot-update
description: Generate or update CONTEXT_SNAPSHOT with minimal, high-signal context for next session.
---

# Trigger Conditions

- **Phase**: Post-slice completion or session end
- **When**: A slice has been merged, or a session is ending with significant progress
- **Who**: All agents (Claude, Codex, Cursor, Antigravity)
- **Signal**: Human requests "update the snapshot"; slice PR is merged; session wrap-up

# Procedure

## 1. Architecture Summary
- Current structure (concise)

## 2. Slice Status
- Completed slices
- Current slice
- Next candidates

## 3. Critical Constraints
- Must-not-break rules
- Architectural invariants

## 4. Required Files
List only essential files for next session

## 5. Known Risks / Open Issues

# Output Format

## Architecture Summary
## Slice Status
## Constraints
## Files to Load
## Risks

# Guardrails
- Keep minimal
- No duplication of full docs
- Optimize for token efficiency
- Update `CONTEXT_SNAPSHOT_latest.md` symlink to point to the new version

# Violation Examples

- ❌ Snapshot duplicates entire Architecture Principles document instead of summarizing
- ❌ "Files to Load" lists every file in the repo instead of the essential 5-10 for next session
- ❌ Omits known design gaps (e.g., Gap A / Gap B from previous snapshot)
- ❌ Snapshot is created but `CONTEXT_SNAPSHOT_latest.md` symlink is not updated
