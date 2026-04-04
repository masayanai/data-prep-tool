# data-prep-tool

Test data preparation tool for the household decision-support system
([automation-platform](../automation-platform)).

## Purpose

Produces anonymized, fixture-ready datasets from real household data sources.
The output feeds integration tests, replay verification, and AI-agent evaluation
in automation-platform without exposing any real personal information.

## Supported Sources

| Source | Description |
|--------|-------------|
| Gmail | Email examples (subject, body, sender patterns) |
| Google Calendar | Calendar events and scheduling patterns |
| Schoology | Homework assignments, course pages |
| School calendar | Academic calendar, holidays, non-school days |

## Output

Anonymized fixture files in the format expected by automation-platform's
test suite. All outputs must satisfy the invariants in
`docs/data-handling-policy.md`.

## Explicit Out of Scope

- Does **not** send, modify, or delete any source data
- Does **not** implement automation-platform business logic
- Does **not** store credentials or raw PII outside the secrets directory
- Does **not** make scheduling or planning decisions

## Quickstart

```bash
uv sync
./scripts/qa.sh
```

## Project Structure

```
src/data_prep_tool/    - Source code
tests/                 - Test suite
docs/                  - Project documentation
  data-handling-policy.md  - PII rules and transformation invariants
  AI_RULES.md              - AI permissions and domain constraints
  TASK_CONTRACT.md         - Required task fields for agents
  review/                  - Review workflow and YAML templates
  architecture/            - Authority order and architecture notes
scripts/qa.sh          - Full QA gate (must pass before commit)
```

## Toolchain

```bash
uv sync                          # install dependencies
uv run pytest                    # run tests
uv run ruff check .              # lint
uv run ruff format . --check     # format check
uv run mypy src tests            # type check
./scripts/qa.sh                  # full QA (all of the above + security)
```

## Commit Conventions

```
feat: description
fix: description
refactor: description
docs: description
chore: description
```
