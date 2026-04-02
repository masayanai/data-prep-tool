# Skill Workflow — TDD Lifecycle Skill Chain

> **Authority position**: Operational Constraints Track **O-4**
> (see `docs/architecture/AUTHORITY_ORDER.md` and ADR-0035).
>
> This document maps available skills to the TDD development lifecycle.
> Every agent should consult the appropriate skill at each phase transition.

## Skill Chain

```
┌─────────────────────────────────────────────────────────────────┐
│                    Slice Lifecycle                               │
│                                                                 │
│  ┌─────────────────────┐                                        │
│  │ slice-design-review  │  ← New slice document created/revised │
│  │ (Before RED)         │    APPROVE → proceed to RED           │
│  └─────────┬───────────┘    BLOCK  → revise slice document      │
│            │                                                    │
│            ▼                                                    │
│  ┌─────────────────────────┐                                    │
│  │ green-implementation-   │  ← Production code changes with    │
│  │ guard (During GREEN)    │    GREEN commit                    │
│  └─────────┬───────────────┘    YES → safe to commit            │
│            │                    NO  → fix violations first       │
│            ▼                                                    │
│  ┌─────────────────────┐                                        │
│  │ refactor-audit       │  ← Production code changes, no test   │
│  │ (After GREEN)        │    changes, REFACTOR commit           │
│  └─────────┬───────────┘    SAFE   → commit                    │
│            │                UNSAFE → revert or fix              │
│            ▼                                                    │
│  ┌─────────────────────────┐                                    │
│  │ pr-summary-and-commit   │  ← Ready to commit or create PR   │
│  │ (Before commit/PR)      │    Generates commit msg + PR body  │
│  └─────────┬───────────────┘                                    │
│            │                                                    │
│            ▼                                                    │
│  ┌─────────────────────────┐                                    │
│  │ context-snapshot-update  │  ← Slice merged or session ending │
│  │ (Session end)            │    Updates CONTEXT_SNAPSHOT_latest │
│  └──────────────────────────┘                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Quick Reference

| TDD Phase          | Skill                        | Gate Decision        |
|--------------------|------------------------------|----------------------|
| Before RED         | `slice-design-review`        | APPROVE / BLOCK      |
| During/After GREEN | `green-implementation-guard`  | YES / NO (proceed)   |
| After GREEN        | `refactor-audit`             | SAFE / UNSAFE        |
| Before Commit/PR   | `pr-summary-and-commit`      | (generates output)   |
| Session End        | `context-snapshot-update`    | (generates snapshot)  |

## Usage Notes

- Skills are **not optional** — every agent must consult the relevant skill at phase transitions.
- Multiple skills may apply in sequence (e.g., `green-implementation-guard` → `pr-summary-and-commit`).
- If a gate skill returns a negative decision (BLOCK / NO / UNSAFE), the agent must **not proceed** to the next phase.
- Skills are located in `docs/ai/skills/<skill-name>/SKILL.md`.
