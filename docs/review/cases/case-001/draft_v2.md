# Minimal anonymization design — CASE-001

**Framing:** `docs/review/cases/case-001/framing_contract.yaml`  
**Agent:** A (draft)  
**Scope:** Email, display/name fields, phone numbers only. Rule-based, deterministic, one-way.

---

## 1. Goals

- Remove real email, person names, and phone numbers from structured or semi-structured inputs while **preserving shape** (keys, nesting, non-PII values).
- **Deterministic:** same canonical value → same surrogate, within a **consistency domain** (one export batch / one `domain_id`).
- **Not reversible:** surrogates must not reveal originals without the **secret key** used for derivation. No raw→surrogate tables in output artifacts.

---

## 2. Threat model (minimal)

- **Protect against:** casual reuse of fixtures, accidental leakage in logs/tests.
- **Assume:** Derivation secret (`ANON_KEY`) stays out of git, fixtures, and logs. If the key leaks, pseudonyms can be recomputed for guessed inputs (inherent limit of deterministic schemes).

---

## 3. Cryptographic primitive

Use **HMAC-SHA256** with a repo-external key:

```
tag = HMAC-SHA256(key, version || "|" || kind || "|" || canonical_value || "|" || domain_id)
```

- `key`: 32+ byte secret (env `DATA_PREP_ANON_KEY` or file under `secrets/`, never committed).
- `domain_id`: stable string for this dataset run (e.g. UUID chosen once per fixture bundle) so two different bundles do not correlate by accident.
- `version`: fixed byte `v1` … string `"v1"` prepended for future algorithm rotation.
- `kind`: `"email" | "phone" | "name"`.

Take the first **N** bits of `tag` as needed to format surrogates (hex or digit constraints below).

No storage of plaintext-to-surrogate mappings on disk for release; an **in-memory cache** during a single run is allowed for speed (same as recomputing HMAC each time).

---

## 4. Canonicalization (before HMAC)

| Kind | Canonical form |
|------|------------------|
| **email** | Unicode NFKC → lowercase → trim → remove display-name glue if stripping to addr-only (e.g. `Name <a@b>` → `a@b`) |
| **phone** | Strip to `+` and digits; normalize to E.164 when unambiguous (minimal: US `1` + 10 digits → `+1` + 10 digits); **error if ambiguous** — tool must halt and name the field rather than pass through raw PII |
| **name** | NFKC → trim → collapse internal whitespace → case-fold for hashing only; surrogate can use a fixed display pattern. Optional `name_aliases` config maps variant strings to a single canonical form before hashing (e.g. `"Ms. Jane Smith" → "jane smith"`) |

**Names:** Start with **configured field paths** only (e.g. JSON `From`, `headers.From`, `contact.displayName`). Optional second phase: regex labeled lines (`From:` / `名前:`) — keep **out of v1** unless framing expands.

---

## 5. Surrogate formats (stable, recognizable in tests)

Aligned with `docs/data-handling-policy.md` spirit; adjust only if policy is updated in lockstep.

| Kind | Format | Notes |
|------|--------|--------|
| **email** | `fake_{8_hex}@example.com` | `8_hex` = first 8 hex chars of HMAC output; matches `docs/data-handling-policy.md` format |
| **phone** | `+1-555-{abcd}` | `abcd` = first 4 hex chars of HMAC (16^4 space; not a real NANP assignable block — clearly fake) |
| **name** | `Person_{6_hex}` | Single string per distinct canonical name; if product later needs given/family split, use same HMAC with `kind` variants `name_full`, `name_given`, `name_family` |

All formats are valid UTF-8 strings; emails use `@example.com` per data-handling policy.

---

## 6. Detection (rule-based)

1. **Emails:** Pattern for addr-spec in structured fields; optional sweep in short text fields with bounded regex `\b\S+@\S+\.\S+\b` (careful with false positives — prefer field-path allowlist first). When parsing `Display Name <addr>` form, the display-name portion is extracted and routed through name surrogate replacement.
2. **Phones:** Small set of patterns (US-centric v1: `(xxx) xxx-xxxx`, `xxx-xxx-xxxx`, `+1...`, optional dots/spaces). Normalize then match. If a value at a configured phone path cannot be normalized, the tool **errors** (no silent pass-through).
3. **Names:** Only values at **explicit paths** from config (YAML/JSON list), plus display-name components extracted from email fields. No statistical NER in v1.

---

## 7. Processing pipeline (single tool)

```
Load input (JSON or simple adapter output)
→ Load config: domain_id, key ref, field paths for name/email/phone
→ Walk tree:
   - At configured leaf paths, run type-specific detector; if hit, replace with surrogate
→ Optional: one regex pass on selected string leaves (email/phone only) if framing allows
→ Emit output JSON (or same schema as input)
```

**Order:** Detect email and phone inside string values before or as part of leaf handling; names are path-driven only in v1.

---

## 8. Referential consistency

Within one `domain_id` and one process run:

- Same canonical email always → same `fake_…@example.com`.
- Same canonical phone → same `+1-555-….`
- Same canonical name string → same `Person_…`.

Across different `domain_id` values, surrogates **must** differ for the same real value (HMAC includes `domain_id`).

---

## 9. Validation (minimal)

Automated checks before write:

- **No raw emails:** Regex scan on output forbids `\S+@\S+\.\S+` except allowlist — only `fake_[0-9a-f]{8}@example.com` permitted.
- **No obvious US phone patterns** outside `+1-555-[0-9a-f]{4}` (practical: scan for `\d{3}[-.\s]?\d{3}[-.\s]?\d{4}` and fail if found).
- **No raw names at configured paths:** Every configured name-path value in output must match `Person_[0-9a-f]{6}`. Fail export if any does not. (Does not catch names leaked to non-configured locations — known v1 limitation.)

---

## 10. Out of scope (per framing)

- OCR / image text  
- Full NLP / multilingual name understanding  
- Perfect global phone coverage  
- Automatic name-variant resolution (e.g. "Jane Smith" vs "Ms. Jane Smith") — users can supply `name_aliases` in config for manual grouping  
- Name detection in unstructured free-text fields beyond display-name components of email addresses

---

## 11. Suggested module layout (future code)

```
src/data_prep_tool/
  canon.py      # normalize email / phone / name
  derive.py     # HMAC surrogates + domain_id
  detect.py     # regex + path dispatch
  transform.py  # tree walk + replace
  validate.py   # output scans
```

Single CLI entry: `data-prep-anonymize --domain-id ... --config paths.yaml < in.json > out.json`

---

## 12. Resolved from review

- **REV-001:** Ambiguous phones → tool errors (no pass-through).
- **REV-002:** Display-name in email addr-spec → routed through name replacement. Free-text names remain out of v1.
- **REV-003:** Name validation gate added (configured-path pattern check before export).
- **REV-004:** Email format aligned to policy (`fake_{8_hex}@example.com`).
- **REV-005:** Optional `name_aliases` config added. Full variant resolution deferred.

---

## References

- `docs/review/cases/case-001/framing_contract.yaml`
- `docs/data-handling-policy.md` (structured field rules)
