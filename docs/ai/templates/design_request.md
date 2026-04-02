# Design Request Template

> **Role**: Template — active reusable artifact
> **Lifecycle**: Active
> **Default load**: No
>
> Fill this template to package a design request per
> `docs/ai/REQUEST_PACKAGING_CONTRACT.md`. Delete the example section
> before submitting.

---

## Front Matter

```yaml
request_kind: design_request
decision_status: open  # open | proposed | accepted
linked_authoritative_sources:
  - # e.g. ARCHITECTURE_PRINCIPLES.md
  - # e.g. docs/ai/AI_RULES.md
  - # e.g. docs/ADR/ADR-XXXX.md
explicit_exclusions:
  - .project-records/ — retained traces, narrow-gate exclusion
  - docs/ai/archive/ — historical artifacts, non-current
  - # add any other intentionally excluded sources with reason
open_questions_or_assumptions:
  - # list unresolved inputs or assumptions the agent should surface
next_action_or_handoff_need: |
  # describe what happens after the agent completes this request
```

---

## Goal

<!-- 1–3 sentences: what exists when this design is complete that does not exist now -->

## Non-goals

<!-- List items a reasonable agent might attempt but that are explicitly excluded -->
-

## Acceptance criteria

<!-- Each criterion must be independently verifiable — by a file check, grep, test, or human review of a specific section -->
-

## Design Context

<!-- Optional: links to prior issues, ADRs, discussions, or decisions that inform this request -->

## Notes

<!-- Implementation hints, ordering constraints, risks, or dependencies -->

---

---

## Example (filled — remove before submitting)

```yaml
request_kind: design_request
decision_status: open
linked_authoritative_sources:
  - ARCHITECTURE_PRINCIPLES.md
  - docs/architecture/AUTHORITY_ORDER.md
  - docs/ai/AI_RULES.md
  - docs/ai/TASK_CONTRACT.md
  - docs/ai/PROJECT_RECORDS_POLICY.md
explicit_exclusions:
  - .project-records/ — retained traces, narrow-gate exclusion
  - docs/ai/archive/ — historical artifacts, non-current
  - issue comments — not swept in by default
open_questions_or_assumptions:
  - Should the contract handle multi-agent handoff as a separate
    request_kind, or is that covered by review_request?
next_action_or_handoff_need: |
  After agent produces the design plan, evaluate for retention under
  PROJECT_RECORDS_POLICY.md and open an implementation task if accepted.
```

### Goal

A documentation-only standard exists for packaging AI design and review
requests so inputs are deterministic, scoped, and reproducible across
agent CLI workflows.

### Non-goals

- Introduce scripts or automation.
- Change `TASK_CONTRACT.md` or any authority document.
- Create a general chat-archival system.
- Add tool-specific behavior tuning.

### Acceptance criteria

- `docs/ai/REQUEST_PACKAGING_CONTRACT.md` exists and states role,
  lifecycle, and non-authoritative relationship.
- A two-tier exclusion rule is defined for `.project-records/` and
  `docs/ai/archive/`.
- Templates exist for `design_request` and `review_request`, each
  preserving TASK_CONTRACT fields.
- `docs/ai/README.md` is updated in all three relevant tables.

### Design Context

Issue #58. Follows the retention policy standard established in Issue #48.

### Notes

- Must not introduce a second authoritative state-transition path.
- Prefer one contract plus thin templates over multiple overlapping files.
