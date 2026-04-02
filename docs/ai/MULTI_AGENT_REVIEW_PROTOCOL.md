# MULTI_AGENT_REVIEW_PROTOCOL.md

> **Role**: Process
> **Lifecycle**: Active stable entrypoint
> **Load by default**: No. Load only when structured multi-agent review is applied.

## 1. Purpose

Define a structured convergence protocol for multi-agent
draft/review/validation workflows.

This protocol improves:
- coverage of reasoning
- detection of blind spots
- correction of review errors

---

## 2. Core Principle

Review is not authoritative.

All review outputs must be validated before application.

Review outputs may contain:
- errors
- misinterpretations
- scope violations

---

## 3. Roles (Agent-Agnostic)

### Draft Agent
- Produces initial artifact
- Validates all review feedback
- Preserves intent

### Review Agent
- Identifies defects and risks
- Does not assume authority

### Validator (Draft Agent)
- Challenges review assumptions
- Detects misunderstandings

---

## 4. Standard Loop

1. Draft (Agent A)
2. Review (Agent B)
3. Validation (Agent A)
4. Re-review (Agent B, optional)

Maximum iterations: 2 cycles

---

## 5. Review Classification

Each review point must be classified as:

- accepted
- rejected
- partially accepted
- needs clarification

Each classification must include rationale.

---

## 6. Stop Conditions

Stop when:

- No new issues are introduced
- Remaining issues are stylistic
- Architecture and tests are aligned

Escalate to human when:

- Conflicting authoritative documents
- Scope expansion required
- Disagreement persists after 2 cycles

---

## 7. Anti-patterns

- Blindly applying review feedback
- Treating review as authoritative
- Infinite loops
- Scope expansion during validation

---

## 8. Logging / Traceability

Recorded review artifacts are non-authoritative trace records.
They must not be used for design decisions, policy inference, or
implementation guidance.

### Slice Work
Each review loop MUST record:

- draft agent
- review agent
- validation agent
- review points
- validation results
- final resolution

### Docs / Chore Work
Each review loop SHOULD record:

- draft agent
- review agent
- validation results
- final resolution

When persisted or evaluated for persistence, review records should follow
`docs/ai/PROJECT_RECORDS_POLICY.md`.

Retained review records belong under `.project-records/`, which is
non-authoritative storage.

AI agents must not read, index, embed, reference, or rely on
`.project-records/` content unless the task explicitly instructs:

- `audit`
- `trace inspection`
- `historical review`

---

## 9. Operating Mode

- Human-orchestrated workflow
- Manual context transfer

Automation is out of scope.
