You are a metadata generator.

Task:
Generate metadata for the current prompt execution.

Inputs:
- prompt_file_path
  docs/review/cases/case-002/prompts/00_draft_prompt.md
- source_template_path (if any)
- case_id case-002

Output:
Produce a markdown header block.

Rules:
- Keep it minimal
- Use current timestamp in ISO-8601
- If source_template_path is unknown, leave empty
- Do not add explanations

Format:

source_template: <path or empty>
template_commit: <leave empty>
generated_at: <ISO-8601 timestamp>
case_id: <case_id>
prompt_file: <prompt_file_path>
notes: []