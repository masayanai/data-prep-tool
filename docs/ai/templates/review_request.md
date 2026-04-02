# Review Request Template

> **Role**: Template — active reusable artifact
> **Lifecycle**: Active
> **Default load**: No
>
> Fill this template to package a review request per
> `docs/ai/REQUEST_PACKAGING_CONTRACT.md`. The agent must produce output
> in the four-section structure defined in §6 of that contract.
> Delete the example section before submitting.

---

## Front Matter

```yaml
request_kind: review_request
decision_status: open  # open | proposed | accepted
linked_authoritative_sources:
  - # authoritative docs relevant to what is being reviewed
  - # e.g. docs/ai/TASK_CONTRACT.md
  - # e.g. docs/ai/AI_RULES.md
explicit_exclusions:
  - .project-records/ — retained traces, narrow-gate exclusion
  - docs/ai/archive/ — historical artifacts, non-current
  - # add any other intentionally excluded sources with reason
open_questions_or_assumptions:
  - # list items the reviewer should surface if uncertain
next_action_or_handoff_need: |
  # describe what happens after the review is complete
```

---

## Goal

<!-- 1–3 sentences: what the review should produce -->

## Non-goals

<!-- What is explicitly out of scope for this review -->
-

## Acceptance criteria

<!-- What a complete, useful review output looks like -->
-

## Artifact Under Review

<!-- Path or link to the artifact being reviewed -->

## Review Scope

<!-- What specifically should be evaluated — be explicit to bound the reviewer -->

## Sources Loaded

<!-- Mirror of linked_authoritative_sources — explicit list for the agent -->
-

## Explicit Exclusions

<!-- Mirror of explicit_exclusions — what the agent must not sweep in -->
-

## Open Questions for Reviewer

<!-- Items the agent should surface if the answer is unclear from loaded sources -->
-

---

## Required Output Structure

The agent must produce output in exactly these four sections.
Do not add, rename, or reorder sections.

```
## Findings
<List of specific findings, each labelled: High / Medium / Low / Non-blocking>

## Open Questions
<Unresolved items the reviewer could not determine from available inputs>

## Scope Exclusions
<What was not reviewed and why — explicit boundary statement>

## Recommended Next Step
<Single concrete action: accept findings, revise artifact, escalate, or close>
```

---

---

## Example (filled — remove before submitting)

```yaml
request_kind: review_request
decision_status: open
linked_authoritative_sources:
  - docs/ai/TASK_CONTRACT.md
  - docs/ai/PROJECT_RECORDS_POLICY.md
  - docs/ai/AI_RULES.md
explicit_exclusions:
  - docs/ai/archive/ — historical artifacts, non-current
  - issue comments — not swept in by default
open_questions_or_assumptions:
  - Is the two-tier exclusion gate sufficient, or should
    .project-records/ always be hardcoded excluded regardless of
    task instruction?
next_action_or_handoff_need: |
  Drafting agent to validate findings, accept or reject each, and
  update the plan. Revise before implementation if any High findings
  remain open.
```

### Goal

Identify any blocking or material issues in the Issue #58 implementation
plan before implementation begins.

### Non-goals

- Redesign the plan from scratch.
- Review files not in scope for Issue #58.
- Produce implementation-ready output directly.

### Acceptance criteria

- All findings classified by severity.
- Open questions explicitly listed.
- A single recommended next step stated.

### Artifact Under Review

`.project-records/sessions/2026-03-31T21-05-49-05-00__session__issue-58-impl-plan.md`
(accessed explicitly for `trace inspection`)

### Review Scope

- Correctness of plan against Issue #58 acceptance criteria
- Compliance with TASK_CONTRACT.md required field definitions
- Correctness of retention boundary statements
- Completeness of README update scope

### Sources Loaded

- `docs/ai/TASK_CONTRACT.md`
- `docs/ai/PROJECT_RECORDS_POLICY.md`
- `docs/ai/AI_RULES.md`

### Explicit Exclusions

- `docs/ai/archive/` — not relevant to this review

### Open Questions for Reviewer

- Are there acceptance criteria in Issue #58 not covered by the plan?

---

## Findings

- **High**: review_request template body omits `Non-goals` and
  `Acceptance criteria`, conflicting with TASK_CONTRACT required fields.
- **Medium**: retention boundary only exempts templates, not active
  request artifacts as a class.
- **Medium**: README update scope does not account for the Directory
  Layout table.

## Open Questions

- Does the Directory Layout table require a new row for
  `REQUEST_PACKAGING_CONTRACT.md`, or is the `docs/ai/` directory row
  sufficient with an updated Notes column?

## Scope Exclusions

- Source code and tests — out of scope for a docs review.
- ADR correctness — not loaded for this review.

## Recommended Next Step

Accept all three findings. Update the plan to correct the review_request
body definition, strengthen the retention boundary statement, and
explicitly scope the README Directory Layout table change before
implementation begins.
