---
name: Chore Task
about: Infrastructure, tooling, or CI changes
labels: chore
---

<!-- This template implements the AI Task Contract (docs/TASK_CONTRACT.md).
     All fields marked REQUIRED must be filled before assigning to an AI agent.
     File scoping is mandatory when touching code, CI configs, or scripts.
     See docs/review/README.md for multi-agent review workflow. -->

## Goal
<!-- REQUIRED: 1–3 sentences. State the infra/tooling change delivered. -->


## Non-goals
<!-- REQUIRED: List items a reasonable agent might attempt but must not. -->

-

## Acceptance criteria
<!-- REQUIRED: Each criterion must be independently verifiable. -->

-

## Files in scope
<!-- REQUIRED when modifying code, CI configs, or scripts. -->

### May modify

- `<file>` — <reason>

### May create

- `<file>` — <purpose>

### Must NOT touch

- `<file>` — <reason>

### May read (optional)
<!-- List files the agent should read for context, when inputs are non-obvious. -->

- `<file>` — <context purpose>

## Verification
<!-- How to confirm the chore succeeded (e.g., ./scripts/qa.sh). -->

```bash

```

## Notes
<!-- Optional: context, dependencies, rollback plan. -->
