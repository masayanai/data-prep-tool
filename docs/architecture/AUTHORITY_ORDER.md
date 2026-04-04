# Architecture Authority Order

This document defines the authority hierarchy for this repository.
All contributors — human or AI — follow this order when interpreting
documents or making implementation decisions.

If documents appear to conflict, the higher-authority document prevails.

---

## Authority Hierarchy

### D-1 — Architecture Principles (highest authority)

```
ARCHITECTURE_PRINCIPLES.md
```

Non-negotiable rules for the system. Nothing may violate these.

---

### D-2 — Data Handling Policy

```
docs/data-handling-policy.md
```

PII classification, transformation rules, and output invariants.
Authoritative on what counts as PII and how it must be handled.

---

### O-1 — All-Agent Behavioral Contract

```
AGENTS.md
```

How all AI agents behave: work categories, task contract, boot sequence,
non-negotiable behavioral constraints.

---

### O-2 — Domain Participation Rules + Permissions

```
docs/AI_RULES.md
```

What AI may and may not do in this repository. Canonical permissions policy.

---

### O-3 — Engineering Practices

```
docs/development/ENGINEERING_PRACTICES.md
```

QA gates, test depth, security review requirements.

---

### O-4 — Tool Boot Files

```
CLAUDE.md / CODEX.md / .cursorrules / ANTIGRAVITY.md
```

Agent-specific operational notes. Defer to O-1 through O-3 for all
substantive rules.

---

## Conflict Resolution

- Design authority (D-1, D-2) governs system interpretation
- Operational constraints (O-1 through O-4) govern contributor behavior
- Both tracks prevail over explainer/derived documents
- Within each track, higher levels override lower levels
- If a conflict cannot be resolved: **do not guess — report to a human**

---

## Non-Authoritative Documents

The following are aids to understanding and hold no authority:

- `docs/review/README.md` — multi-agent review workflow guide
- `.project-records/` — retained records (non-authoritative)
