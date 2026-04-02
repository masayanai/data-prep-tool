# Prompt: GREEN → REFACTOR Handoff 作成依頼

> **Role**: Generator
> **Lifecycle**: Active reusable artifact
> **Load by default**: No. Use only when generating a GREEN -> REFACTOR handoff document.

## 使い方
以下のプロンプトをそのままClaudeに渡す。`{{XX}}` と `{{name}}` を実際のスライス番号と名前に置き換えること。

---

## Prompt

以下のファイルを読んで、Slice {{XX}} の GREEN → REFACTOR ハンドオフ文書を作成してください。

### 読むファイル（この順序で）

1. `docs/ai/templates/GREEN_TO_REFACTOR_HANDOFF_TEMPLATE.md` — 出力テンプレート
2. `docs/platform/slices/vertical_slice_{{XX}}.md` — Must Preserve の根拠（公開シグネチャ・定数・データモデル）
3. `src/openclaw/{{module}}/` 配下の実装ファイル — Refactor Targets の特定（コードレビュー）
4. `tests/test_{{name}}.py` — テスト数の確認・Validation コマンドの正確な記述

### 出力ルール

- テンプレートの全セクションを埋めること
- `{{placeholder}}` を全て実際の値に置き換えること
- 説明・理論・背景は書かない（箇条書き・コード・表のみ）
- Refactor Targets は実装ファイルを読んだ上で **コード品質の問題を実際に特定** して記述すること
  - 問題がなければ該当 P を削除してよい
  - 優先度順に並べ、P1 が最も影響範囲が大きいもの
  - 「〜を検討する」ではなく「〜に変更する」と具体的に書く
- Must Preserve の VERSION_CONSTANT は実装ファイルから verbatim でコピーすること
- Must NOT Do はスライス固有の禁止事項のみ残し、汎用的すぎる項目は削除してよい

### 出力先

`docs/ai/archive/handoffs/GREEN_TO_REFACTOR_HANDOFF_{{XX}}.md`

### 確認事項

作成後、以下を確認すること：
- テンプレートの全 `{{placeholder}}` が残っていない
- Refactor Targets が「実際のコードに基づいている」（架空の問題を書かない）
