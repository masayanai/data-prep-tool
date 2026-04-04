# AI Task Contract — Required Fields and Authoring Rules

> **Authority**: Supporting document referenced by `AGENTS.md` (O-1).
> This document holds no independent authority in the Operational
> Constraints Track. If it conflicts with AGENTS.md, AGENTS.md prevails.
> (See `docs/architecture/AUTHORITY_ORDER.md` and ADR-0035.)
>
> **Scope**: This document defines the **required structure** for tasks
> assigned to AI agents. It applies to all work categories
> (slice, docs, chore) with category-specific relaxations noted below.

---

## Purpose

AI agents perform best with explicit, bounded task definitions.
This contract standardizes the fields every task must include so that
agents receive consistent boundaries regardless of who authors the task
or which tool executes it.

---

## Required Fields

Every AI-facing implementation task MUST include these three fields:

| Field | Purpose | Required for |
|-------|---------|--------------|
| **Goal** | 1–3 sentence description of the desired outcome | all categories |
| **Non-goals** | Explicit boundaries — what the task must NOT do | all categories |
| **Acceptance criteria** | Observable, verifiable conditions that define "done" | all categories |

Additionally, **Files in scope** is category-dependent:

| Field | Purpose | Required for |
|-------|---------|--------------|
| **Files in scope** | Files the agent may read, create, or modify | **mandatory** for `slice` and code-touching `chore`; **recommended** for `docs` and non-code `chore` |

See §Files in Scope Rules below for the full policy.

### Goal

State the deliverable, not the process. A goal answers "what exists
when this task is complete that does not exist now?"

Good: "A standard task contract exists for AI-assisted implementation work."
Bad: "Improve templates."

### Non-goals

List items that a reasonable agent might attempt but that are explicitly
excluded. Non-goals prevent scope creep and reduce ambiguity at
boundaries.

Good: "Tool-specific prompt tuning for every AI product."
Bad: (omitted entirely)

### Acceptance criteria

Each criterion must be independently verifiable — either by a test,
a file check, a grep, or a human reviewer reading a specific section.
Avoid subjective language ("improved", "better", "cleaner") unless
paired with an observable indicator.

### Files in scope

See §Files in Scope Rules below for when this field is mandatory
versus recommended.

---

## Files in Scope Rules

### Mandatory file scoping (strict mode)

File scoping is **mandatory** for:

- **slice** work — all TDD phases (RED, GREEN, REFACTOR, DOC)
- **chore** work that modifies production code, CI configs, or scripts

When mandatory, the task MUST list:

- Files the agent may **modify** (with reason)
- Files the agent may **create** (with purpose)
- Files the agent must **NOT touch** (if ambiguity exists)
- Files the agent should **read** for context (optional — include when
  the relevant inputs are non-obvious or span multiple directories)

### Recommended file scoping (relaxed mode)

File scoping is **recommended but not mandatory** for:

- **docs** work that only adds or edits documentation files
- **chore** work limited to non-code artifacts (e.g., README updates)

When relaxed, the task SHOULD still specify:

- The target directory or document set
- Any documents that must NOT be altered (especially authority documents)

### Rationale

Strict file scoping prevents agents from drifting into unrelated code
during implementation. Docs-only work typically has a narrower blast
radius and can rely on the "Change Boundaries" rules in AGENTS.md
instead of an exhaustive file list.

---

## Optional Fields

These fields are not required but improve task clarity:

| Field | Purpose |
|-------|---------|
| **Context / background** | Links to prior issues, ADRs, or discussions |
| **Notes** | Implementation hints, ordering suggestions, risks |
| **Work category** | Explicit `slice` / `docs` / `chore` label (required if ambiguous) |
| **Depends on** | Predecessor tasks that must complete first |

---

## Authoring Rules

These rules reduce ambiguity in AI-facing task descriptions:

1. **Use imperative mood for acceptance criteria.**
   Write "A template exists for…" not "Create a template for…".
   Acceptance criteria describe end-state, not process.

2. **Scope non-goals to plausible drift.**
   Only list non-goals an agent might reasonably attempt. Do not
   pad with irrelevant exclusions.

3. **Prefer concrete file paths over descriptions.**
   Write `docs/TASK_CONTRACT.md` not "the task contract document".

4. **State verification method when non-obvious.**
   If an acceptance criterion requires a specific check (grep, test run,
   file existence), state it.

5. **One goal per task.**
   If a task has multiple independent goals, split into separate tasks.
   Composite goals cause agents to lose track of acceptance boundaries.

6. **Mark work category explicitly when the category is ambiguous.**
   A task that updates both docs and a CI script should state which
   category governs (typically the higher-risk one).

---

## Category-Specific Contract Shapes

### Slice task contract

```
## Goal
<1–3 sentences: what the slice delivers>

## Non-goals
- <plausible drift item 1>
- <plausible drift item 2>

## Acceptance criteria
- <verifiable end-state 1>
- <verifiable end-state 2>

## Files in scope (mandatory)
### May modify
- <file> — <reason>

### May create
- <file> — <purpose>

### Must NOT touch
- <file> — <reason>

### May read (optional — include when inputs are non-obvious)
- <file> — <context purpose>

## Notes
- <implementation hints, ordering, risks>
```

### Docs task contract

```
## Goal
<1–3 sentences: what documentation change is delivered>

## Non-goals
- <plausible drift item>

## Acceptance criteria
- <verifiable end-state 1>
- <verifiable end-state 2>

## Scope (recommended)
- Target documents: <list or directory>
- Must NOT alter: <authority documents, ADRs, etc.>

## Notes
- <context, dependencies>
```

### Chore task contract

```
## Goal
<1–3 sentences: what infra/tooling change is delivered>

## Non-goals
- <plausible drift item>

## Acceptance criteria
- <verifiable end-state 1>
- <verifiable end-state 2>

## Files in scope (mandatory if touching code/CI)
### May modify
- <file> — <reason>

### May create
- <file> — <purpose>

### Must NOT touch
- <file> — <reason>

### May read (optional — include when inputs are non-obvious)
- <file> — <context purpose>

## Verification
- <how to confirm the chore succeeded — e.g., `./scripts/qa.sh`>
```

---

## Relationship to Existing Documents

This contract complements (does not replace):

- **AGENTS.md** (O-1) — defines behavioral rules; references this contract
  for task-level field requirements
- **ENGINEERING_PRACTICES.md** (O-3) — defines test depth and development
  workflow; this contract defines task input shape
- **docs/review/** — YAML records for framing, review, validation, verification, and close
- **GitHub issue templates** (`.github/ISSUE_TEMPLATE/`) — instantiate
  this contract for GitHub-based task tracking

---

## See Also

- `AGENTS.md` — All-agent behavioral contract
- `docs/review/README.md` — Minimal multi-agent review workflow
- `docs/development/ENGINEERING_PRACTICES.md` — Development practices
- `.github/ISSUE_TEMPLATE/` — GitHub issue templates implementing this contract
