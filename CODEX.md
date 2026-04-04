# CODEX.md — OpenAI Codex Boot Instructions

> Codex-specific configuration. Shared agent rules are in `AGENTS.md`.

## Boot Sequence

Before any work, follow `AGENTS.md` for shared rules and read these files in order:

1. `AGENTS.md` — all-agent behavioral contract (READ FIRST)
2. `ARCHITECTURE_PRINCIPLES.md` — system constitution
3. `docs/architecture/AUTHORITY_ORDER.md` — canonical authority hierarchy
4. `docs/AI_RULES.md` — AI participation rules and permissions policy
5. `docs/development/ENGINEERING_PRACTICES.md` — development practices

Consult when relevant:

- `docs/review/README.md` — minimal multi-agent review workflow and review mode

## Multi-Agent Review

For complex or high-risk changes, use the flow in `docs/review/README.md`.

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

## Codex-Specific Notes

- Codex operates in a sandboxed environment. Always run `uv sync` before
  executing tests.
- Keep each task request scoped to a single TDD phase (RED, GREEN, or REFACTOR).
- Do NOT create PRs directly — output the diff and commit message for human
  review.
- When given a task, always state which TDD phase you are operating in before
  producing code.
- For repository operation permissions and escalation rules, defer to
  `docs/AI_RULES.md` (Operational Permissions Policy).
