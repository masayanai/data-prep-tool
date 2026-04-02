# docs/ai — AI Documentation Map

This directory contains the AI agent infrastructure for data-prep-tool.

---

## Default Boot Inputs (read every session)

These are loaded as part of the boot sequence defined in `AGENTS.md`:

| File | Type | When to load |
|------|------|-------------|
| `ARCHITECTURE_PRINCIPLES.md` (root) | authority | every session |
| `docs/ai/AI_RULES.md` | authority | every session |
| `docs/development/ENGINEERING_PRACTICES.md` | authority | every session |
| `docs/data-handling-policy.md` | authority | every session |

---

## Context and Navigation

| File | Purpose |
|------|---------|
| `docs/ai/README.md` | This file — navigation map |
| `docs/ai/CONTEXT_SNAPSHOT_latest.md` | Current phase and recent progress (non-authoritative) |

---

## Stable Reference Documents

| File | Type | When to use |
|------|------|-------------|
| `docs/ai/TASK_CONTRACT.md` | contract | when authoring or receiving a task |
| `docs/ai/REVIEW_MODE_PROTOCOL.md` | protocol | when inquiry starts with `review mode:` |
| `docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md` | protocol | when applying multi-agent review |
| `docs/ai/REQUEST_PACKAGING_CONTRACT.md` | contract | when packaging a request |
| `docs/ai/prompts/PROMPT_md_output.md` | prompt contract | when Markdown output is requested |
| `docs/ai/skills/SKILL_WORKFLOW.md` | process | at TDD phase transitions |
| `docs/ai/skills/*/SKILL.md` | skill | loaded through `SKILL_WORKFLOW.md` |

---

## Templates and Generators

Not default boot inputs. Load only when creating artifacts.

| File | Purpose |
|------|---------|
| `docs/ai/templates/design_request.md` | Design review request template |
| `docs/ai/templates/review_request.md` | Code review request template |
| `docs/ai/templates/CONTEXT_SNAPSHOT_TEMPLATE.md` | Snapshot template |
| `docs/ai/templates/RED_TO_GREEN_HANDOFF_TEMPLATE.md` | RED→GREEN handoff |
| `docs/ai/templates/GREEN_TO_REFACTOR_HANDOFF_TEMPLATE.md` | GREEN→REFACTOR handoff |
| `docs/ai/generators/PROMPT_create_red_to_green_handoff.md` | Generate RED→GREEN handoff |
| `docs/ai/generators/PROMPT_create_green_to_refactor_handoff.md` | Generate GREEN→REFACTOR handoff |

---

## Authority Boundary

Documents in `docs/ai/` (except `AI_RULES.md`) are supporting documents.
They assist understanding and provide templates, but do not override
`ARCHITECTURE_PRINCIPLES.md`, `docs/data-handling-policy.md`, or `AGENTS.md`.

`.project-records/` is non-authoritative retained-record storage.
Do not load it by default.
