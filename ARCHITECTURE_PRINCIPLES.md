# Architecture Principles — data-prep-tool

> **Authority position**: Design Authority Track **D-1** (highest authority).
> Nothing in this repository may violate these principles.

---

## 1. Purpose

data-prep-tool is a **one-way data preparation utility**.

It reads from household data sources and writes anonymized fixture files.
It does not participate in household decision-making, planning, or automation.

---

## 2. Non-Negotiable Safety Rules

1. **No real PII in output** — All personally identifiable information must be
   replaced or redacted before writing fixtures. Raw source data must never
   appear in fixture output files.

2. **No source data mutation** — This tool is read-only with respect to all
   external sources. It must never send, modify, or delete data in Gmail,
   Google Calendar, Schoology, or any other source.

3. **No credentials in code** — API keys, tokens, and passwords must live in
   the `secrets/` directory or environment variables. They must never appear
   in source code, tests, logs, or fixture output.

4. **Referential consistency is required** — When the same real identity
   (person, school, location) appears across multiple sources in a dataset,
   it must map to the same synthetic identity in the output unless explicitly
   modeled as a different entity.

5. **Deterministic transforms for structured fields** — Email addresses,
   phone numbers, school names, student IDs, and dates must be replaced
   using deterministic rules, not LLM generation. LLM assistance is limited
   to free-text fields where structural patterns alone are insufficient.

6. **Leak detection is mandatory** — Every output fixture must pass a
   leak-detection check that verifies no real PII survives the transform.

---

## 3. System Boundary

data-prep-tool is a **standalone CLI tool**, not a service or platform.

- It has no runtime API
- It has no persistent state beyond fixture output files
- It is not part of the automation-platform event pipeline
- It does not communicate with automation-platform at runtime

---

## 4. Pipeline Architecture

All data preparation follows this stage order:

```
Source Adapter → PII Detection → Replacement / Redaction → Validation → Fixture Export
```

No stage may skip PII detection.
No stage may write to the fixture output path before validation passes.

---

## 5. Architecture Change Rule

Any change that modifies the pipeline stage order, introduces a new source
adapter, changes the PII detection strategy, or alters output fixture schema
requires human review before implementation.

AI agents must not make these changes unilaterally. Ask first.
