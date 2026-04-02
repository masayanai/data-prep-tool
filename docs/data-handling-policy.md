# Data Handling Policy

> This document defines PII classification, transformation rules, and
> output invariants for all data processed by data-prep-tool.
>
> **Authority**: This policy is binding on all source adapters, transforms,
> and fixture export code. It may not be weakened without explicit human review.

---

## 1. What Counts as PII

The following fields are always treated as PII regardless of source:

| Category | Examples |
|----------|---------|
| Names | First name, last name, display name, username |
| Contact | Email address, phone number |
| Location | Home address, school address, zip/postal code |
| Identifiers | Student ID, school ID, account ID, user ID |
| Dates (contextual) | Birthdate; event dates that reveal personal patterns |
| Free text | Email body, assignment descriptions, calendar event titles (may contain any of the above) |

When uncertain, treat the field as PII.

---

## 2. Transformation Rules by Field Type

### Structured fields — deterministic replacement

These fields must be replaced using deterministic rules (hash-based or
lookup-table-based), not AI generation.

| Field | Rule |
|-------|------|
| Email address | Replace with `fake_{hash8}@example.com` |
| Name | Replace via consistent fake-identity mapping (see §3) |
| Phone number | Replace with `+1-555-{hash4}` |
| Student / account ID | Replace with `ID-{hash8}` |
| School name | Replace via school-name lookup table |
| Street address | Replace with `{N} Fake St, Fakeville` |

### Date fields

- **Preserve relative structure** (e.g., assignment due Monday → still due Monday)
- **Shift by a fixed offset** per dataset rather than removing dates
- **Birthdate**: remove entirely or replace with age-range string (`"age 12-14"`)

### Free-text fields

- Run structured-field replacement first (regex-based sweep)
- Use LLM assistance only for residual free-text PII that structured rules miss
- Output must still pass leak-detection before being written

---

## 3. Referential Consistency

A **consistency domain** is a single dataset (e.g., one student's fixture set
covering Gmail + Calendar + Schoology).

Within a consistency domain:
- The same real person always maps to the same fake identity
- The same school always maps to the same fake school name
- The same teacher always maps to the same fake teacher name

The mapping table for a consistency domain must be generated once and reused
across all source adapters for that domain. It must not be regenerated
mid-pipeline.

Across different consistency domains, mappings need not be consistent.

---

## 4. Output Invariants

Every exported fixture file must satisfy all of the following:

1. **No raw email addresses** — zero matches for `\S+@\S+\.\S+` except
   `@example.com` addresses
2. **No real names** — names in the fake-identity mapping table must not
   appear in output
3. **No real IDs** — original student/account IDs must not appear in output
4. **Schema preserved** — output structure matches the input schema contract
   (field names, nesting, types)
5. **Same person maps consistently** — within a consistency domain, the same
   fake identity is used for the same real person throughout

These invariants are verified by leak-detection tests.  
**No fixture file may be committed unless its invariants pass.**

---

## 5. Reversibility

Fixture transforms are **one-way by default**.

The mapping table may be retained in a local-only, secrets-adjacent file if
round-trip debugging is needed, but:
- Mapping tables must never be committed to git
- Mapping tables must never appear in fixture output
- If not needed for debugging, discard immediately after fixture export

---

## 6. Logging and Debug Output

- Raw source data must never be written to log files or debug output
- Log messages may include field names and structural metadata, but not field values
- Exception tracebacks must be sanitized before logging if they may contain field values

---

## 7. Secrets

- Source credentials (OAuth tokens, API keys) live in `secrets/` (gitignored)
- No credential may appear in source code, tests, fixtures, or log output
- Secrets are injected via file reference or environment variable only
