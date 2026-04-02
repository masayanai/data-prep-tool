# Request Packaging Contract

> **Role**: Request packaging contract — active reusable artifact
> **Lifecycle**: Active
> **Stable path**: `docs/ai/REQUEST_PACKAGING_CONTRACT.md`
>
> **Authority**: Non-authoritative. This document does not participate in
> conflict resolution. If it conflicts with `AGENTS.md`, `AI_RULES.md`,
> `TASK_CONTRACT.md`, or `PROJECT_RECORDS_POLICY.md`, those documents
> prevail. See `docs/architecture/AUTHORITY_ORDER.md` and ADR-0035.

---

## Purpose

This document defines the standard for packaging AI design and review
requests so that inputs are deterministic, scoped, and reproducible
across agent CLI workflows.

It complements `docs/ai/TASK_CONTRACT.md` — which defines required task
fields — by adding a request-assembly layer: how to select, scope, and
sequence inputs before invoking an agent. The two documents work together;
neither replaces the other.

---

## 1. Role, Lifecycle, and Authority Boundary

- **Role**: Active reusable artifact — not an authority document, not
  archive material
- **Lifecycle**: Active
- **Non-authoritative relationship**:

| Document | Relationship |
|----------|-------------|
| `AGENTS.md` (O-1) | Behavioral rules for all agents. This contract is subordinate. |
| `docs/ai/AI_RULES.md` (O-3) | Domain-specific constraints. This contract is subordinate. |
| `docs/ai/TASK_CONTRACT.md` | Defines required task fields. This contract adds request-assembly metadata on top — it does not replace any TASK_CONTRACT field. |
| `docs/ai/PROJECT_RECORDS_POLICY.md` | Governs retention of post-hoc summaries. Active request artifacts are out of scope for that policy. |
| `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md` | Defines the review workflow. This contract defines input packaging for review requests. |

If a conflict exists between this document and any of the above,
the higher-authority document prevails. Report unresolvable conflicts
to a human rather than guessing.

---

## 2. Design-Process Checklist

Every request package must include the `TASK_CONTRACT.md` required fields
plus the following request metadata. These fields are **additive** — they
do not replace `Goal`, `Non-goals`, or `Acceptance criteria`.

### Required TASK_CONTRACT fields (preserved, not replaced)

| Field | Purpose |
|-------|---------|
| **Goal** | What exists when the task is complete (1–3 sentences) |
| **Non-goals** | What the task must NOT do |
| **Acceptance criteria** | Verifiable conditions that define "done" |

### Additional request metadata (additive)

| Field | Allowed values / format | Purpose |
|-------|-------------------------|---------|
| `request_kind` | `design_request` \| `review_request` | Type of request |
| `decision_status` | `open` \| `proposed` \| `accepted` | Current decision state |
| `linked_authoritative_sources` | List of file paths or document identifiers | Sources the agent must load before producing output |
| `explicit_exclusions` | List with reasons | Sources intentionally NOT included |
| `open_questions_or_assumptions` | List | Unresolved inputs or assumptions the agent should surface |
| `next_action_or_handoff_need` | Free text | What happens after the agent completes work |

---

## 3. Deterministic Input-Loading

### Source precedence (highest to lowest)

1. `ARCHITECTURE_PRINCIPLES.md`
2. `docs/architecture/AUTHORITY_ORDER.md`
3. `docs/ai/AI_RULES.md`
4. Relevant ADRs for the domain in scope
5. Relevant slice specification or app charter
6. `docs/ai/CONTEXT_SNAPSHOT_latest.md`

### Default inclusions

Load only the sources from the precedence list that are relevant to the
request scope. Do not sweep in the full precedence list for every request.
State inclusions explicitly in `linked_authoritative_sources`.

### Default exclusions (two-tier)

**Narrow gate** — excluded unless the task explicitly calls for
`audit`, `trace inspection`, or `historical review`, or the current
`review mode:` request intentionally includes one concrete
`.project-records/...` file path:

- `.project-records/` — non-authoritative retained trace storage.
  In `review mode:`, only the explicitly named file is included; the
  directory and unnamed sibling files remain excluded.
- `docs/ai/archive/` — historical artifacts, non-current by default

**Broad gate** — excluded by default, may be included when
intentionally selected:

- Issue comments and prior discussion threads
- Chat transcripts from prior sessions

### Normalization expectations

- The agent must load all sources listed in `linked_authoritative_sources`
  before producing output.
- No implicit context sweeping. If a source is not listed, it is excluded.
- If a listed source conflicts with a higher-authority document, the
  higher-authority document prevails and the conflict must be surfaced in
  the output.

---

## 4. Active Request Artifacts vs. Retained Trace Outputs

Active request artifacts — including blank templates, filled request
packages, and in-progress working drafts — are **not** retention
candidates. They remain outside `.project-records/`.

Only normalized post-hoc summaries of session outcomes may be evaluated
as capture candidates under `docs/ai/PROJECT_RECORDS_POLICY.md`.

| Artifact type | Location | Retention candidate? |
|---------------|----------|----------------------|
| Blank template | `docs/ai/templates/` | No |
| Filled request package | Issue, PR body, or working file | No |
| Normalized post-hoc summary | Evaluated per `PROJECT_RECORDS_POLICY.md` | Possibly yes |
| Raw chat transcript | Not retained | No |

---

## 5. Documented Execution Pattern

This pattern documents the human-run `gh → local package → agent CLI →
normalized output` flow. No scripts or automation are required or
introduced here.

```
1. Fetch issue context (gh)
   Use gh to retrieve the issue that defines the work:

     gh issue view <number>

   Extract Goal, Non-goals, Acceptance criteria, Scope, and Notes.
   These become the primary inputs for filling the request package.
   Issue comments are excluded by default unless intentionally selected.

2. Select template
   Choose docs/ai/templates/design_request.md or review_request.md.

3. Fill required fields (local package)
   Complete all TASK_CONTRACT fields (Goal, Non-goals, Acceptance criteria)
   from the issue output.
   Complete all additive checklist fields.
   List linked_authoritative_sources explicitly — these are what the
   agent will load.
   List explicit_exclusions explicitly — state what is NOT included
   and why.

4. Invoke agent CLI
   Pass the filled request package to the agent.
   The agent loads the listed sources before producing output.
   The agent must not sweep in unlisted sources.

5. Capture normalized output
   Record the agent's output in a form suitable for human review.
   For review requests, the agent must use the four-section structure
   defined in §6.

6. Evaluate for retention (optional)
   If the session produced material reasoning, validated decisions, or
   handoff context, evaluate whether a normalized post-hoc summary
   qualifies for retention under docs/ai/PROJECT_RECORDS_POLICY.md.
   Active request packages do not qualify. Only normalized summaries do.
```

---

## 6. Review-Output Normalized Structure

Review request outputs must be structured in exactly four sections.
Agents producing review output must follow this structure without
adding, renaming, or reordering sections.

```
## Findings
<List of specific findings, each labelled: High / Medium / Low / Non-blocking>

## Open Questions
<Unresolved items the reviewer could not determine from available inputs>

## Scope Exclusions
<What was not reviewed and why — explicit boundary statement>

## Recommended Next Step
<Single concrete action: accept finding, revise plan, escalate, or close>
```

---

## See Also

- `docs/ai/TASK_CONTRACT.md` — Required task fields and authoring rules
- `docs/ai/AI_RULES.md` — Domain-specific AI constraints
- `AGENTS.md` — All-agent behavioral contract
- `docs/ai/PROJECT_RECORDS_POLICY.md` — Retention policy for post-hoc summaries
- `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md` — Structured review workflow
- `docs/ai/templates/design_request.md` — Design request template
- `docs/ai/templates/review_request.md` — Review request template
