# Markdown Output Contract

When an AI agent is asked to produce Markdown output (documents, reports,
fixture specs, etc.), apply the following rules:

## Formatting Rules

- Use ATX headings (`#`, `##`, `###`) — no underline-style headings
- Use fenced code blocks with language identifiers (` ```python `, ` ```bash `, etc.)
- Use tables for structured comparisons; keep columns aligned
- Use unordered lists (`-`) for non-sequential items
- Use ordered lists (`1.`) only for sequential steps or ranked items
- No trailing whitespace
- Single blank line between sections
- Line endings: LF (Unix)

## Content Rules

- Do not include real PII in any output document
- Do not include credentials, tokens, or secrets in any output
- Do not speculate about system behavior not documented in authority documents
- Cite the source document when referencing a rule or constraint
- Use imperative mood for instructions ("Run `./scripts/qa.sh`", not "You should run")

## Scope Rules

- Produce only what the task requests — no unrequested additions
- Do not add speculative future sections ("Future Work", "Potential Improvements")
  unless explicitly requested
- If a document already exists, update it in place — do not create a duplicate
