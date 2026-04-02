# Context Snapshot v01

> **Classification**: Explainer / Context Aid — non-authoritative.
> Does not override `ARCHITECTURE_PRINCIPLES.md`, `docs/data-handling-policy.md`,
> or `AGENTS.md`.

---

## Current Phase

**Bootstrap** — project infrastructure established, no source adapters implemented yet.

---

## What Is Complete

- `pyproject.toml` with uv + Python 3.12
- `scripts/qa.sh` (ruff, mypy, pytest, bandit, pip-audit)
- `.venv` with Python 3.12
- `src/data_prep_tool/` (empty placeholder)
- `tests/` (empty placeholder)
- `README.md` — project scope
- `ARCHITECTURE_PRINCIPLES.md` — system constitution
- `docs/data-handling-policy.md` — PII rules and output invariants
- `AGENTS.md` — all-agent behavioral contract
- `docs/ai/AI_RULES.md` — domain participation rules and permissions
- `docs/development/ENGINEERING_PRACTICES.md` — QA gate and test depth
- `docs/architecture/AUTHORITY_ORDER.md` — authority hierarchy
- `docs/ai/` — skills, templates, generators, prompts (paths fixed from copied template)
- CI workflows (`.github/workflows/ci.yml`, `ci-security.yml`) — Python 3.12 + uv

---

## What Is Not Yet Implemented

- Gmail source adapter
- Google Calendar source adapter
- Schoology source adapter
- School calendar source adapter
- PII detection pipeline
- Deterministic transform library
- Referential consistency mapping
- Leak-detection test harness
- Fixture export

---

## Next Step

Implement one source adapter end-to-end (Gmail recommended as first target).

Suggested task sequence:
1. Design the pipeline stage interfaces (design doc / ADR if schema decisions are involved)
2. Write leak-detection test harness (Class A — test-first)
3. Implement Gmail source adapter (fetch + schema extraction)
4. Implement PII detection for Gmail fields
5. Implement deterministic transforms for structured fields
6. Implement fixture export with validation gate

---

## Key Decisions Made

- **uv + Python 3.12** as standard toolchain (consistent with automation-platform)
- **Lighter governance model** — no two-track ADR system; `ARCHITECTURE_PRINCIPLES.md` +
  `data-handling-policy.md` are the authority documents
- **Deterministic transforms for structured fields** — LLM assistance only for
  residual free-text PII
- **Referential consistency** is a first-class requirement within a consistency domain
- **Leak-detection tests** are written before the transforms they cover
