You are Agent A (Draft Agent).

Input:
- framing_contract.yaml

Task:
Design a minimal v1 anonymization tool for CASE-002.

Requirements:
- nested JSON and semi-structured text are in scope
- use a rule-based, config-driven approach first
- deterministic transformation
- one-way anonymization only
- no silent pass-through for configured in-scope PII
- keep the design small and implementable

Focus on:
- configured paths for structured fields
- configured text fields for limited text scanning
- email, person name, and phone only

Output:
- a concise design document in markdown

Do not include implementation code.
Do not include review comments.