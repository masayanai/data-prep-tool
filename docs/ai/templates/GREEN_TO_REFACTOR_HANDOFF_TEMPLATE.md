# GREEN → REFACTOR Handoff: Slice {{XX}} — {{Name}}

> **Role**: Template
> **Lifecycle**: Active reusable artifact
> **Load by default**: No. Use only when creating a GREEN -> REFACTOR handoff artifact.

## Identity
- Slice: `{{XX}}`
- Module: `openclaw.{{module}}`
- Branch: `feat/slice-{{XX}}-{{name}}`
- Spec: `docs/platform/slices/vertical_slice_{{XX}}.md`

## GREEN State
- Tests: {{N}} passed, 0 failed, 0 error
- `./scripts/qa.sh`: fully passing
- Committed: yes

## Refactor Objective
Improve internal code quality of `{{primary_file}}` without changing behavior.

## Primary Target
```
{{src/openclaw/module/file.py}}   ← refactor here
```

## Must Preserve
- All {{N}} tests pass: `uv run pytest tests/test_{{name}}.py -v`
- `./scripts/qa.sh` fully passes
- Public signatures unchanged: `{{function_a()}}`, `{{function_b()}}`
- `__all__` in `__init__.py` unchanged
- {{dataclass_name}} field definitions unchanged
- `{{VERSION_CONSTANT}} = "{{value}}"` unchanged
- No behavior change across all execution paths

## Must NOT Do
- Modify `tests/test_{{name}}.py` — Charter rule
- Modify `{{other_locked_files}}` — {{reason}}
- Modify any upstream pipeline stage — Slice {{XX}} authority boundary
- Add new public exports
- Add persistence, HTTP calls, or external integrations
- Push directly to `main`

## Refactor Targets

### P1 — {{title}}
{{concise description of the code quality issue and suggested fix}}

### P2 — {{title}}
{{concise description of the code quality issue and suggested fix}}

## Validation
```bash
uv run pytest tests/test_{{name}}.py -v   # {{N}} passed, 0 failed
./scripts/qa.sh                           # ruff + mypy + pytest all pass
```

## Commit
```
slice-{{XX}} REFACTOR: {{description}}
```
