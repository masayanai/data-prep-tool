# RED → GREEN Handoff: Slice {{XX}} — {{Name}}

> **Role**: Template
> **Lifecycle**: Active reusable artifact
> **Load by default**: No. Use only when creating a RED -> GREEN handoff artifact.

## Identity
- Slice: `{{XX}}`
- Module: `openclaw.{{module}}`
- Branch: `feat/slice-{{XX}}-{{name}}`
- Spec: `docs/platform/slices/vertical_slice_{{XX}}.md`

## RED State
- Tests collected: {{N}}
- FAILED (NotImplementedError): {{M}}
- PASSED at RED: {{K}} — {{reason: e.g. frozen dataclass / __all__ checks require no implementation}}
- ERROR: 0

## GREEN Target

### Implement — exhaustive list
- `{{file}}` — `{{function/class}}`: {{one-line description}}

### Must NOT touch
- `tests/test_{{name}}.py` — Charter rule: no test modification
- `{{other files}}` — {{reason}}

## Entry Points

```python
{{paste function signatures from spec verbatim}}
```

## Key Implementation Notes
- {{concise bullet — critical constraint or non-obvious requirement}}
- {{e.g. use `derive_raw_event_id()` not `raw.provider_event_id`}}
- {{e.g. `policy_outcome_type` must be string literal, not dynamic}}

## Critical Tests
Tests that will fail if implementation shortcuts are taken:
- `test_{{N}}_{{name}}` — {{why it is hard to game}}

## Validation
```bash
uv run pytest tests/test_{{name}}.py -v   # {{N}} passed, 0 failed
./scripts/qa.sh                           # ruff + mypy + pytest all pass
```

## Commit
```
slice-{{XX}} GREEN: {{description}}
```
