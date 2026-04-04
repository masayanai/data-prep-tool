# ANTIGRAVITY.md — Antigravity Boot Instructions

> Antigravity-specific configuration. Shared agent rules are in `AGENTS.md`.

## Boot Sequence

Before any work, follow `AGENTS.md` for shared rules and read these files in order:

1. `AGENTS.md` — all-agent behavioral contract (READ FIRST)
2. `ARCHITECTURE_PRINCIPLES.md` — system constitution
3. `docs/architecture/AUTHORITY_ORDER.md` — canonical authority hierarchy
4. `docs/AI_RULES.md` — AI participation rules and permissions policy
5. `docs/development/ENGINEERING_PRACTICES.md` — development practices

Consult when relevant:

- `docs/review/README.md` — minimal multi-agent review workflow and review mode

## Toolchain

```bash
uv sync                          # dependency management
./scripts/qa.sh                  # full QA (run before commit)
uv run ruff check .              # lint
uv run ruff format . --check     # format check
uv run mypy src tests            # type check
uv run pytest                    # tests
```

## Commit Conventions

```
feat: description
fix: description
refactor: description
docs: description    ← documentation-only changes
chore: description   ← infrastructure / tooling changes
```

## Antigravity-Specific Notes

- When operating autonomously, always confirm the current TDD phase before
  generating code.
- Respect the authority boundary: AI outputs are proposals, not decisions.
- If a task spans multiple TDD phases, break it into separate operations and
  confirm each phase transition.
- Run `./scripts/qa.sh` after each phase to verify no regressions.
- For repository operation permissions and escalation rules, defer to
  `docs/AI_RULES.md` (Operational Permissions Policy).
