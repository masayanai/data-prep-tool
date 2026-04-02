# AI Rules — data-prep-tool Domain Participation Constraints

> **Scope**: Defines what AI may and may not do in this repository.
> Includes the canonical operational permissions policy.
>
> For behavioral rules (how to behave, TDD process, output style),
> see `AGENTS.md`.

---

## AI Role

AI acts as an **implementation assistant** for data preparation pipelines.

AI may:
- Generate source adapter code within task scope
- Write PII replacement transforms and leak-detection tests
- Propose refactoring that preserves pipeline behavior
- Draft documentation and policy documents (with human review)
- Assist with free-text anonymization prompts

AI must not:
- Determine which fields count as PII — that is defined in `docs/data-handling-policy.md`
- Generate fixture output that contains real PII
- Access external sources outside the current task's adapter scope
- Change the PII detection strategy or pipeline stage order without human approval

---

## Multi-Agent Interaction

AI agents may review and critique outputs from other agents.
All such reviews are advisory and never authoritative.
See `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md` for the protocol.

---

## Architectural Boundaries

AI must not introduce changes that violate:
- Pipeline stage order (Source Adapter → PII Detection → Replacement → Validation → Export)
- Referential consistency rules (same real identity → same fake identity within a domain)
- Deterministic transform requirement for structured fields
- Leak-detection gate before fixture export
- Read-only constraint on external sources

If a proposal would affect any of these, AI must ask before implementing.

---

## Operational Permissions Policy

### Task Modes

- **docs-only** — applies to `docs` work category
- **code-changing** — applies to `feat`, `fix`, `refactor`, and code-touching `chore`

When ambiguous, apply the more restrictive (code-changing) mode.

### Read Permissions

| Target | Status |
|--------|--------|
| Committed repository files needed for the task | **allowed** |
| Other committed repository files (context, docs) | **allowed** |
| `.project-records/` content | **forbidden by default**; allowed only when the task explicitly instructs `audit`, `trace inspection`, or `historical review`, or when the current `review mode:` inquiry explicitly names one concrete `.project-records/...` file path |
| `secrets/`, `.env`, credentials, API keys | **forbidden** |
| Raw source data from Gmail / Calendar / Schoology | **allowed during adapter development**; must not be persisted outside `secrets/` |

### Review Mode Record Exception

When the current inquiry begins with `review mode:`:

- If no prior `.project-records/...` path is provided, the agent may create
  one new review-chain sub-directory and one response file under
  `.project-records/`.
- If the inquiry explicitly names one concrete `.project-records/...` file,
  the agent may read only that exact file and may write only one new response
  file in the same sub-directory.
- Directory scans, globbing, indexing, embedding, or reliance on unnamed
  sibling files under `.project-records/` are forbidden.

### Write Permissions — docs-only mode

| Target | Status |
|--------|--------|
| Documentation files in task scope | **allowed** |
| AI-facing instruction files in task scope | **allowed** |
| Review Mode record file under `.project-records/` | **allowed only per Review Mode Record Exception** |
| `src/`, `tests/` | **forbidden** |
| CI workflows, scripts | **forbidden** unless task explicitly reclassifies |
| `ARCHITECTURE_PRINCIPLES.md`, `docs/data-handling-policy.md` | **forbidden** |
| Secret material, `.env` files | **forbidden** |

### Write Permissions — code-changing mode

| Target | Status |
|--------|--------|
| Task-scoped code under `src/` | **allowed** |
| Task-scoped tests under `tests/` | **allowed** |
| Task-scoped documentation | **allowed** |
| Fixture output files (after validation passes) | **allowed** |
| Review Mode record file under `.project-records/` | **allowed only per Review Mode Record Exception** |
| CI, scripts, configs | **requires approval** |
| `ARCHITECTURE_PRINCIPLES.md`, `docs/data-handling-policy.md` | **requires approval** |
| Secret material, `.env` files, raw PII | **forbidden** |
| Files outside task scope | **requires approval** |

### Execute Permissions

| Command class | Status |
|---------------|--------|
| Read-only inspection: `cat`, `grep`, `find`, `ls`, `diff` | **allowed** |
| Targeted validation: `uv run pytest`, `uv run ruff`, `uv run mypy`, `./scripts/qa.sh` | **allowed** |
| `uv sync` (lockfile-based) | **allowed** |
| Networked commands (curl, API calls, etc.) | **requires approval** |
| Dependency additions (`uv add`) | **requires approval** |
| Commands that write to external sources (Gmail, Calendar, Schoology) | **forbidden** |
| Commands that embed credentials in arguments | **forbidden** |

### Git Permissions

| Operation | Status |
|-----------|--------|
| Inspect: `status`, `diff`, `log`, `show` | **allowed** |
| `fetch`, `pull --ff-only` | **allowed** |
| `commit` (after QA gate passes, within task scope) | **allowed** |
| `switch`, `checkout`, `merge`, `rebase` | **requires approval** |
| `push` (to feature branches) | **requires approval** |
| `push` to `main` | **forbidden** |
| `push --force`, `reset --hard`, force history rewrite | **forbidden** |

### Escalation Triggers

An agent MUST stop and request human approval when:

- An action crosses from "allowed" to "requires approval"
- A destructive or irreversible operation is about to be performed
- Real PII may be written to any output or log
- An external source write is about to occur
- Credentials or raw source data would be exposed
- The change would affect PII detection logic, pipeline stage order, or fixture schema

---

## Domain-Specific Constraints

- PII field definitions in `docs/data-handling-policy.md` are authoritative — AI must not redefine them
- Structured-field transforms must be deterministic — AI must not substitute LLM generation for hash/lookup-based rules on structured fields
- Leak-detection tests must be written before the transform they cover (test-first)
- Mapping tables are ephemeral — AI must not commit them to git or write them to fixture output
- `secrets/` is gitignored and must stay that way — AI must not add secrets to git tracking

---

## When AI Must Ask

AI must request human clarification if:
- PII classification of a new field type is unclear
- A new source adapter requires external-write access
- A transform would change the output schema
- Security or privacy implications exist and the policy doesn't cover them
- The change might affect `docs/data-handling-policy.md` constraints
