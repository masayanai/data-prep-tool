# Prompt Templates & Metadata Usage Guide

This directory contains **prompt templates** used in the review workflow.

## Purpose

- standardize agent behavior
- ensure consistency across cases
- enable reproducibility and auditability

---

## Files Overview

- `draft_creation_prompt_template.md`  
  → used to generate initial design drafts

- `review_prompt_template.md`  
  → used for independent review

- `resolution_prompt_template.md`  
  → used to decide how to handle findings

- `verification_prompt_template.md`  
  → used to confirm fixes

- `metadata_generator.md`  
  → used to generate metadata header for prompt execution

---

# Core Concept

Each execution must capture:

1. **what prompt was used**
2. **when it was used**
3. **in which case it was used**

This is required for:
- replayability
- audit trace
- prompt quality comparison

---

# IMPORTANT RULE

> Metadata must be generated **before execution**, not after.

---

# Standard Workflow (per prompt)

## Step 1 — Copy template

Copy the template into a case-specific location:

```
docs/review/cases/<case-id>/prompts/
```

Example:

```
docs/review/cases/case-002/prompts/review_prompt.md
```

---

## Step 2 — Generate metadata

Use `metadata_generator.md` to produce metadata.

Example input:

- prompt_file_path: review_prompt.md
- source_template_path: docs/prompts/review_prompt_template.md
- case_id: CASE-002

---

## Step 3 — Attach metadata

Add metadata to the top of the prompt file:

```
source_template: docs/prompts/review_prompt_template.md
template_commit:
generated_at: 2026-04-04T12:00:00Z
case_id: CASE-002
prompt_file: review_prompt.md
notes: []

---

<actual prompt content>
```

---

## Step 4 — Execute

Use this exact prompt file for execution.

> Do NOT modify the prompt after execution.

---

# Why Metadata Must Be Attached Before Execution

If metadata is generated after execution:

- prompt and metadata may diverge
- execution cannot be reproduced
- audit trail becomes unreliable

Correct approach:

```
prepare prompt → attach metadata → execute
```

---

# What Metadata Captures

| Field | Purpose |
|------|--------|
| source_template | origin of the prompt |
| template_commit | Git state (optional) |
| generated_at | execution timestamp |
| case_id | linkage to case |
| prompt_file | file identity |
| notes | case-specific changes |

---

# What NOT to Do

- do not store metadata separately from prompt
- do not generate metadata after execution
- do not overwrite prompt files after use
- do not modify template files for case-specific logic

---

# Relationship with Templates

| Component | Role |
|----------|------|
| template (this directory) | reusable definition |
| case prompts | execution snapshot |
| metadata | execution context |

---

# Philosophy

Templates define behavior.  
Cases record execution.  
Metadata preserves reality.

---

# One-Line Summary

> Always execute a prompt **with metadata attached and fixed before execution**.