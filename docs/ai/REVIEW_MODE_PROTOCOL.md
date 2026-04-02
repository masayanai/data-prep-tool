# REVIEW_MODE_PROTOCOL.md

> **Role**: Process
> **Lifecycle**: Active stable entrypoint
> **Load by default**: No. Load only when an inquiry begins with `review mode:`.

## 1. Purpose

Define a lightweight, file-based handoff protocol for multi-agent review.
Any AI agent (Claude Code, Codex CLI, Gemini CLI, etc.) that detects the
`review mode:` prefix MUST follow this protocol to record its response and
return a file path the human can pass to the next agent.

---

## 2. Trigger

An inquiry triggers this protocol when its **first characters** (trimmed) are:

```
review mode:
```

Case-insensitive. Everything after `review mode:` is the inquiry content.

---

## 3. Storage Layout

```
.project-records/
  <yyyy-mm-dd-hh-mm>-<topic>/        ← sub-directory (created by first agent)
    <hh-mm>-<topic>-<summary>.md     ← one file per agent response
    <hh-mm>-<topic>-<summary>.md     ← reviewer's response (same directory)
    ...
```

| Segment | Rule |
|---------|------|
| `yyyy-mm-dd` | ISO date of the response (local time) |
| `hh-mm` (directory) | Wall-clock time when the first response is written |
| `<topic>` | High-level topic derived from the inquiry — kebab-case, ≤ 5 words |
| `hh-mm` (filename) | Wall-clock time when **this** file is written |
| `<summary>` | One lowercase word describing this response (e.g. `analysis`, `review`, `validation`, `response`) |

The first responding agent creates the sub-directory.
Subsequent agents in the same review chain append files to it.

---

## 4. File Format

Follow `docs/ai/prompts/PROMPT_md_output.md` for all formatting rules.

Each record file MUST include these sections, in order:

```markdown
# <topic> — <summary>

## Inquiry

<Exact text of the inquiry (after "review mode:")>

## Agent

<Agent name or tool identifier, if known (e.g. "Claude Code / claude-sonnet-4-6")>

## Response

<Full response content>

## Classification

<For review responses only — classify each point per MULTI_AGENT_REVIEW_PROTOCOL.md §5>
```

Omit `## Classification` for the initial (non-review) response.

---

## 5. Response Requirement

The agent's visible reply to the human MUST end with:

```
Saved: .project-records/<sub-directory>/<filename>.md
```

This line is the handoff pointer. To continue the same review chain, the human
MUST pass this exact path to the next agent.
If the human pastes only content without a concrete `.project-records/...`
path, the next agent MUST treat that request as a new review chain unless the
prompt also provides `Chain path: .project-records/...`.

---

## 6. Review Chain

When an agent receives a `review mode:` inquiry that explicitly references one
concrete `.project-records/...` path from a previous record:

1. Read the referenced file and no other `.project-records/` file unless the
   prompt explicitly names it too.
2. Identify the sub-directory from the path.
3. Write the review response into the **same sub-directory** using a new
   `hh-mm-<topic>-<summary>.md` filename.
4. End the visible reply with `Saved:` pointing to the new file.

The review back-and-forth continues until:

- No new issues remain, or
- Maximum 2 cycles are reached (see `MULTI_AGENT_REVIEW_PROTOCOL.md §4`), or
- The human stops passing paths.

---

## 7. Constraints

- `.project-records/` is non-authoritative retained-record storage.
  Do NOT use these files for design decisions, policy inference, or
  implementation guidance unless the task explicitly requests
  `audit`, `trace inspection`, or `historical review`.
- Review Mode exact-path exception: when the current `review mode:` inquiry
  explicitly names one concrete `.project-records/...` file, the agent may
  read that exact file as handoff context only and may write one new response
  file in the same sub-directory. This does not authorize directory scanning
  or reading unnamed sibling files.
- Do not include real PII, credentials, or secrets in any record file.
- Record files are local workflow artifacts and should remain gitignored
  by default.
