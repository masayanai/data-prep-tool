# Engineering Practices

> **Authority position**: Operational Constraints Track **O-3**
> (see `docs/architecture/AUTHORITY_ORDER.md`).

---

## 1. Development Workflow

This project is developed test-first. AI assistance is used throughout,
so practices must be explicit enough for both humans and agents to apply
consistently.

### RED → GREEN → REFACTOR

1. **RED** — Write failing tests that specify the behavior. Do not implement yet.
2. **GREEN** — Write the minimum code to pass the tests. Do not modify tests.
3. **REFACTOR** — Improve structure without changing observable behavior.

AI agents must not modify existing tests to make a failing test pass.

### Leak-Detection Tests First

For every PII transform, write the leak-detection test before writing the
transform. The test must verify that no real PII survives in the output.
This is non-negotiable.

---

## 2. QA Gate

Every commit must pass the full QA gate:

```bash
./scripts/qa.sh
```

Which runs in order:

```bash
uv run ruff format . --check   # formatting
uv run ruff check .            # linting
uv run mypy src tests          # type checking
uv run pytest                  # tests
uv run bandit -r src -x tests  # security static analysis
uv run pip-audit               # dependency vulnerability check
```

Do not commit if any step fails.

---

## 3. Test Depth

Not all code requires the same test intensity. Apply test depth based on risk.

### Class A — Strong Test-First Required

Behavior must be specified by tests before implementation. Use named test
cases that document the invariant.

- PII detection logic
- Deterministic transform rules (email, name, ID replacement)
- Referential consistency (same input → same output within a domain)
- Leak-detection assertions
- Pipeline stage ordering

### Class B — Standard Coverage

Write tests, but a full suite of edge cases is not required.

- Source adapters (integration tests covering happy path and common errors)
- Fixture export (schema validation, file structure)
- CLI entry points

### Class C — Minimal or Indirect Coverage

These can be covered by higher-level tests. Dedicated unit tests optional.

- Thin I/O wrappers
- Logging utilities
- Configuration loading
- CLI plumbing

---

## 4. Security Practices

### PII and Secrets

- Never write real PII to test fixtures, logs, or debug output
- Never write credentials to source code, test files, or git history
- Secrets live in `secrets/` (gitignored) or environment variables only
- Run `bandit -r src` before every commit

### Dependency Hygiene

- Run `pip-audit` before every commit
- Do not add dependencies without reviewing their transitive graph
- Pin exact versions in `pyproject.toml` dev dependencies

### Source Access

- Source adapters have read-only access to external sources
- Any operation that could modify an external source requires explicit
  human approval before implementation

---

## 5. Type Checking

All code in `src/` and `tests/` must pass `mypy` with the settings in
`pyproject.toml`. New code must not suppress type errors with `# type: ignore`
without a comment explaining why.

---

## 6. Code Style

- Line length: 100 characters (`ruff` enforced)
- Formatting: `ruff format` (double quotes, space indentation, LF line endings)
- Import ordering: `ruff` (I rules)

---

## 7. Commit Conventions

```
feat: description      ← new feature or source adapter
fix: description       ← bug fix
refactor: description  ← no behavior change
docs: description      ← documentation only
chore: description     ← tooling, CI, dependencies
```

Use imperative mood. Keep subject line under 72 characters.
Body is optional but useful for non-obvious decisions.

---

## 8. AI Agent Rules

- AI must not modify tests to make them pass
- AI must not commit without the QA gate passing
- AI must not add dependencies without human approval
- AI must not push to `main`
- AI-generated tests require human review before merge
- AI may write leak-detection tests and PII transform code within task scope
