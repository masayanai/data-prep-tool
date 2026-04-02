# AGENTS.md — All-Agent Behavioral Contract

> **Scope**: Defines how all AI agents behave in this repository —
> regardless of tool (Claude, Codex, Cursor, Antigravity, ChatGPT, Gemini, etc.).
>
> For domain-specific constraints (what you may/may not touch),
> see `docs/ai/AI_RULES.md`.

---

## Work Categories

Every task falls into one of these categories:

- **feat** — new feature or source adapter (TDD: tests first)
- **fix** — bug fix in existing code
- **refactor** — structural improvement, no behavior change
- **docs** — documentation changes only
- **chore** — infrastructure, tooling, CI changes

Identify the category before starting work. The category determines which
rules and checklists apply below.

---

## Task Contract (All Categories)

Every task assigned to an AI agent MUST include:

- **Goal** — what exists when the task is complete (1–3 sentences)
- **Non-goals** — what the task must NOT do
- **Acceptance criteria** — verifiable conditions that define "done"

**Files in scope** is required for `feat`, `fix`, `refactor`, and code-touching
`chore` work. List files the agent may modify, create, and must NOT touch.

If a task is missing required fields, the agent MUST request clarification
before starting work. Do not infer missing boundaries.

See `docs/ai/TASK_CONTRACT.md` for full contract shapes and templates.

---

## Boot Sequence (All Agents)

Every session MUST begin with:

1. Read `ARCHITECTURE_PRINCIPLES.md` — system constitution (highest authority)
2. Read `docs/ai/AI_RULES.md` — domain-specific participation rules and permissions
3. Read `docs/development/ENGINEERING_PRACTICES.md` — development practices
4. Read `docs/data-handling-policy.md` — PII rules and output invariants

Refer to as needed:

- `docs/ai/README.md` — navigation map for docs/ai/
- `docs/ai/CONTEXT_SNAPSHOT_latest.md` — current phase and recent progress

---

## Non-Negotiable Behavioral Constraints

- Never write real PII to fixture files, logs, or test output
- Preserve pipeline stage order: Source Adapter → PII Detection → Replacement → Validation → Export
- No hidden side effects on external sources (read-only access only)
- Do not weaken PII detection or bypass leak-detection validation
- Prefer narrower behavior over convenience when boundaries are unclear

---

## Multi-Agent Review

For complex reasoning, high-risk changes, or uncertainty in interpretation,
agents SHOULD apply a structured multi-agent review process.

Protocol: `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md`

### When to Apply

- Ambiguous requirements or unclear boundaries
- Changes to PII detection or transformation logic
- New source adapters
- Non-trivial refactoring

### Constraints

- Review is advisory only — does not override authority documents
- Final decisions must comply with `ARCHITECTURE_PRINCIPLES.md` and `AI_RULES.md`
- Maximum 2 review cycles; escalate to human if unresolved

---

## TDD Rules (feat and fix work)

Follow RED → GREEN → REFACTOR:

- **RED**: Write failing tests only. Do not implement behavior.
- **GREEN**: Implement minimum code to pass tests. Do not modify tests.
- **REFACTOR**: No behavior change. Improve structure and naming only.

Leak-detection tests must be written before the transform they cover.

---

## Change Boundaries

### feat / fix / refactor work

Do NOT modify unless explicitly required:
- CI / infra configs
- `docs/data-handling-policy.md`
- `ARCHITECTURE_PRINCIPLES.md`
- Other source adapters outside current task scope

### docs work

- Limit changes to the specific documents requested
- Do not alter `ARCHITECTURE_PRINCIPLES.md` or `docs/data-handling-policy.md`
  unless the task explicitly requires it

### chore work

- Limit changes to the specific infra/tooling target
- Do not modify production code or test behavior

---

## Required Behavior Before Work

You MUST state:
1. The task category and goal
2. What must NOT be done (non-goals)
3. Which files you will modify or create

---

## Required Behavior After Work

You MUST:
- List changed files
- Confirm scope was not exceeded
- State remaining risks or follow-ups

---

## Output Style

- Concise, explicit, implementation-oriented
- No speculative architecture
- No silent scope expansion

The Markdown output contract is `docs/ai/prompts/PROMPT_md_output.md`.

---

## See Also

- `docs/ai/TASK_CONTRACT.md` — task field requirements
- `docs/ai/AI_RULES.md` — domain constraints and permissions policy
- `docs/ai/skills/SKILL_WORKFLOW.md` — skill chain and trigger map
- `.github/ISSUE_TEMPLATE/` — GitHub issue templates
- `CLAUDE.md` / `CODEX.md` / `.cursorrules` / `ANTIGRAVITY.md` — agent boot files
