# Prompt: RED → GREEN Handoff 作成依頼

> **Role**: Generator
> **Lifecycle**: Active reusable artifact
> **Load by default**: No. Use only when generating a RED -> GREEN handoff document.

## 使い方
以下のプロンプトをそのままClaudeに渡す。`{{XX}}` と `{{name}}` を実際のスライス番号と名前に置き換えること。

---

## Prompt

以下のファイルを読んで、Slice {{XX}} の RED → GREEN ハンドオフ文書を作成してください。

### 読むファイル（この順序で）

1. `docs/ai/templates/RED_TO_GREEN_HANDOFF_TEMPLATE.md` — 出力テンプレート
2. `docs/platform/slices/vertical_slice_{{XX}}.md` — GREEN Scope・Entry Points・What Must NOT Do
3. `tests/test_{{name}}.py` — テスト一覧・PASS at RED の特定・Critical Tests の特定
4. `src/openclaw/{{module}}/` 配下のスタブファイル — 実装済み範囲の確認

### 出力ルール

- テンプレートの全セクションを埋めること
- `{{placeholder}}` を全て実際の値に置き換えること
- 説明・理論・背景は書かない（箇条書き・コード・表のみ）
- Entry Points はスペックから verbatim でコピーする
- Critical Tests は「実装をショートカットすると通らない」テストのみ列挙する（全テストを列挙しない）
- PASSED at RED の理由は1行で簡潔に書く

### 出力先

`docs/ai/archive/handoffs/RED_TO_GREEN_HANDOFF_{{XX}}.md`

### 確認事項

作成後、テンプレートの全 `{{placeholder}}` が残っていないことを確認すること。
