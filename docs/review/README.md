# Structured review workflow

Minimal multi-agent flow for drafting and checking changes. Advisory only; `ARCHITECTURE_PRINCIPLES.md`, `docs/data-handling-policy.md`, `AGENTS.md`, and `docs/AI_RULES.md` still win on conflicts.

## Steps

1. **Framing** — Human copies `template/framing_contract.yaml` to `records/<slug>/`, fills it, sets `approved_by_human: true`.
2. **Draft** — Agent A implements per framing; notes `framing_id` in PR/commits as needed.
3. **Review** — Agent B sees only approved framing + draft artifacts (see Isolation); writes `review_record.yaml`.
4. **Validation** — Agent A fixes must-fix items, runs QA, writes `validation_record.yaml`.
5. **Verification** — Agent B or C confirms scope and checks; writes `verification_record.yaml`.
6. **Human close** — Human merges or sends back; writes `close_record.yaml`.

## Review mode (`review mode:`)

When a chat starts with `review mode:` (case-insensitive): write the full reply as Markdown under `.project-records/<dated-topic>/` using a new file per turn; end the visible reply with `Saved: .project-records/...`. Read `.project-records/` only via an exact path the human gave. Do not glob or scan that directory.

## Isolation

- **Reviewer may see:** approved framing, draft diff/files named in framing, and safety docs if framing says they are in scope.
- **Reviewer must not see:** other chat threads, credentials, raw PII, paths in framing `deny`, or validation/verification records until after their review is done.
- **Verifier may see:** final diff (or PR), framing, `review_record.yaml`, `validation_record.yaml`, and cited CI/logs.

## Templates

Copy from `docs/review/template/*.yaml` into `docs/review/records/<slug>/` (add per-record copies; keep secrets and PII out of git).
