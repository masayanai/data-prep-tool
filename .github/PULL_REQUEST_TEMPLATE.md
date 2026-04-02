<!-- Link to the originating task (issue or task contract). -->
**Task**: #<!-- issue number -->

## Summary

- What changed:
- Why this change is needed:
- Scope of impact:

## Architecture Boundary Check

Please confirm all that apply:

- [ ] External input is treated as untrusted and validated
- [ ] Normalization remains structural only
- [ ] No semantic interpretation was added to normalization
- [ ] AI/extractor output remains advisory only
- [ ] No authoritative event typing was added before deterministic policy evaluation
- [ ] No approval or review boundary was bypassed
- [ ] Side effects occur only after policy evaluation

## Security Check

- [ ] No secrets were added to code, logs, fixtures, or docs
- [ ] No raw sensitive content is logged
- [ ] No unsafe subprocess, shell execution, eval, or unsafe deserialization was introduced
- [ ] File paths, commands, and external inputs are validated or constrained
- [ ] Dependency changes were reviewed for necessity and security impact

## Determinism / Replayability Check

- [ ] Behavior remains deterministic for identical input + policy version
- [ ] No hidden non-deterministic dependency was introduced
- [ ] Replay/audit identifiers are preserved where required

## Testing

- [ ] Added or updated tests for expected behavior
- [ ] Added or updated tests for rejection / boundary behavior
- [ ] Added or updated tests for review fallback where relevant
- [ ] Added or updated redaction / logging safety tests where relevant

## Multi-Agent Review Trace (if applied)

<!-- Fill this section when the multi-agent review protocol was used.
     Required for slice work; recommended for docs/chore work.
     See docs/ai/MULTI_AGENT_REVIEW_PROTOCOL.md for the full protocol.
     See docs/ai/README.md for the AI docs map and stable entrypoints.
     This trace supports future "Development Activity as Auditable Events"
     (see docs/architecture/platform-evolution-roadmap.md §4). -->

- Drafter:
- Reviewer:
- Validator:
- Cycles completed: <!-- 1 or 2 -->

### Review Points

<!-- Copy one block per review point. -->

- Issue:
  - Classification: <!-- accepted / rejected / partially accepted / needs clarification -->
  - Rationale:

### Validation Summary

- Accepted:
- Rejected:
- Remaining uncertainty:

### Outcome

- <!-- accepted / revised / escalated -->

## Notes for Reviewers

- Areas that need careful review:
- Known limitations:
- Follow-up work intentionally not included:
