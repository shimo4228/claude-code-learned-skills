# Claude Code Learned Skills

> 実際のClaude Code使用経験から学んだ実践的なパターンとベストプラクティス集

このリポジトリには、実際のClaude Code開発セッションから抽出された**39個の実戦スキル**が含まれています。[Agent Skills 標準](https://agentskills.io/specification)に準拠しています。

[English](README.md) | **日本語**

## ディレクトリ構成

```
skills/
├── ai-era-architecture-principles/SKILL.md
├── brainstorming-communication/SKILL.md
├── cjk-aware-text-metrics/SKILL.md
├── ...
└── zenn-textlint-workarounds/SKILL.md
```

各スキルは `skills/{スキル名}/SKILL.md` に配置され、Agent Skills 対応ツールから発見可能な YAML frontmatter を含みます。

---

## スキル一覧 (39)

### アーキテクチャ

| スキル | 説明 |
|--------|------|
| [ai-era-architecture-principles](skills/ai-era-architecture-principles/SKILL.md) | フレームワーク採用判断マトリクス：AI時代のカスタム vs 大規模フレームワーク |
| [algorithm-migration-with-rollback](skills/algorithm-migration-with-rollback/SKILL.md) | コアアルゴリズム（暗号化、ハッシュ、ML）のロールバック安全な移行パターン |
| [service-layer-extraction](skills/service-layer-extraction/SKILL.md) | Typer/Click CLIからビジネスロジックをテスト可能なサービス層に抽出 |

### Claude Code

| スキル | 説明 |
|--------|------|
| [claude-code-tool-patterns](skills/claude-code-tool-patterns/SKILL.md) | 大ファイル書込み性能、Edit更新パターン、Hook JSONエスケープの罠 |
| [claude-code-self-generation-over-api](skills/claude-code-self-generation-over-api/SKILL.md) | Maxプランでは外部APIより先に自己生成を検討 |
| [claude-code-mcp-manual-install](skills/claude-code-mcp-manual-install/SKILL.md) | セッション内からjqでMCPサーバーを手動追加 |
| [parallel-subagent-batch-merge](skills/parallel-subagent-batch-merge/SKILL.md) | 50件以上のデータを並列サブエージェントで生成・統合 |
| [skill-stocktaking-process](skills/skill-stocktaking-process/SKILL.md) | 文字数予算を意識した4段階スキル統廃合 |
| [directory-structure-enforcement-hooks](skills/directory-structure-enforcement-hooks/SKILL.md) | PreToolUse + Stop hookによるディレクトリ構造の3層防御 |
| [cross-source-fact-verification](skills/cross-source-fact-verification/SKILL.md) | 複数の独立ソースによるドラフトのファクトチェック |

### LLM

| スキル | 説明 |
|--------|------|
| [cjk-aware-text-metrics](skills/cjk-aware-text-metrics/SKILL.md) | CJK/Latin加重トークン推定（多言語パイプライン向け） |
| [cost-aware-llm-pipeline](skills/cost-aware-llm-pipeline/SKILL.md) | モデルルーティング、予算追跡、リトライによるLLMコスト制御 |
| [data-generation-quality-metrics-loop](skills/data-generation-quality-metrics-loop/SKILL.md) | 定量メトリクスによる生成→測定→修正の反復ループ |
| [deep-research-api-landscape](skills/deep-research-api-landscape/SKILL.md) | 公式Deep Research API（OpenAI, Gemini, Perplexity）でブラウザ自動化を代替 |
| [keyword-based-llm-eval](skills/keyword-based-llm-eval/SKILL.md) | キーワードマッチングとF1メトリクスによるLLM出力評価 |
| [long-document-llm-pipeline](skills/long-document-llm-pipeline/SKILL.md) | 5万文字超のドキュメントをセクション分割でLLM処理 |
| [regex-vs-llm-structured-text](skills/regex-vs-llm-structured-text/SKILL.md) | 構造化テキスト解析：正規表現優先、LLMはエッジケースのみ |

### プロセス

| スキル | 説明 |
|--------|------|
| [root-cause-challenge-pattern](skills/root-cause-challenge-pattern/SKILL.md) | 5段階意思決定フレームワーク：複雑さを増す前に前提を疑う |
| [brainstorming-communication](skills/brainstorming-communication/SKILL.md) | アイデア探索 vs 実装フェーズのコミュニケーションプロトコル |
| [json-data-validation-test-design](skills/json-data-validation-test-design/SKILL.md) | 自動生成JSONデータの多層pytestバリデーション |

### Python

| スキル | 説明 |
|--------|------|
| [backward-compatible-frozen-extension](skills/backward-compatible-frozen-extension/SKILL.md) | frozen dataclass/Pydanticの後方互換フィールド拡張 |
| [content-hash-cache-pattern](skills/content-hash-cache-pattern/SKILL.md) | SHA-256コンテンツハッシュによる高コスト処理結果のキャッシュ |
| [mock-friendly-api-layering](skills/mock-friendly-api-layering/SKILL.md) | mock assertionが失敗するAPI層構造の修正パターン |
| [python-immutable-accumulator](skills/python-immutable-accumulator/SKILL.md) | frozen dataclass + tuple蓄積パターン（`__slots__`の罠付き） |
| [python-optional-dependencies](skills/python-optional-dependencies/SKILL.md) | pyproject.toml extras、ランタイムチェック、ファクトリパターン |
| [python-module-to-package-refactor](skills/python-module-to-package-refactor/SKILL.md) | モジュール→パッケージリファクタリング（`mock.patch`ターゲット更新付き） |
| [textual-tui-pipeline-interception](skills/textual-tui-pipeline-interception/SKILL.md) | Textual TUIによるCLIパイプラインへのインタラクティブレビュー挿入 |

### Swift / iOS

| スキル | 説明 |
|--------|------|
| [immutable-model-updates](skills/immutable-model-updates/SKILL.md) | Swift構造体のスレッドセーフな不変更新パターン |
| [protocol-di-testing](skills/protocol-di-testing/SKILL.md) | プロトコルベースDIによるSwiftコードのテスト手法 |
| [swift-actor-persistence](skills/swift-actor-persistence/SKILL.md) | Swiftアクターによるスレッドセーフなデータ永続化層 |
| [swift-codable-decode-diagnosis](skills/swift-codable-decode-diagnosis/SKILL.md) | Swift CodableのJSONデコードエラー診断手法 |
| [xcode-package-swift-misidentification](skills/xcode-package-swift-misidentification/SKILL.md) | Package.swift誤認識によるシミュレータ起動失敗の対処 |
| [xcode-pbxproj-file-registration](skills/xcode-pbxproj-file-registration/SKILL.md) | Xcode外で追加した.swiftファイルのpbxproj登録 |

### 技術記事 (Zenn/Qiita)

| スキル | 説明 |
|--------|------|
| [tech-writing-patterns](skills/tech-writing-patterns/SKILL.md) | クロスポスト、トーン調整、品質パターン |
| [zenn-context-driven-writing](skills/zenn-context-driven-writing/SKILL.md) | ドラフト前のコンテキスト収集・構造化ワークフロー |
| [zenn-qiita-crosspost-workflow](skills/zenn-qiita-crosspost-workflow/SKILL.md) | 自動Zenn→Qiita変換パイプライン |
| [prh-hyphen-regex-escape](skills/prh-hyphen-regex-escape/SKILL.md) | Node.js 20+でのprhハイフンパターンのunicode正規表現非互換 |
| [zenn-markdownlint-config](skills/zenn-markdownlint-config/SKILL.md) | Zenn固有のmarkdownlint-cli2ルール設定 |
| [zenn-textlint-workarounds](skills/zenn-textlint-workarounds/SKILL.md) | Zenn記事向けの既知の誤検出と回避策 |

---

## 使用方法

### 個別スキルのインストール

```bash
# グローバルにインストール
cp skills/python-immutable-accumulator/SKILL.md \
   ~/.claude/skills/learned/python-immutable-accumulator.md

# プロジェクトにインストール
cp skills/zenn-markdownlint-config/SKILL.md \
   your-project/.claude/skills/learned/zenn-markdownlint-config.md
```

### 全スキルのインストール

```bash
# 全スキルをコピー（Claude Code互換のフラット.md形式）
for dir in skills/*/; do
  name=$(basename "$dir")
  cp "$dir/SKILL.md" ~/.claude/skills/learned/"$name".md
done
```

---

## Agent Skills 標準

各 `SKILL.md` は [Agent Skills 仕様](https://agentskills.io/specification)に準拠した YAML frontmatter を含みます:

```yaml
---
name: skill-name
description: "Use when ... トリガーフレーズ。簡潔な説明。"
license: MIT
metadata:
  author: shimo4228
  version: "1.0"
  extracted: "2026-02-08"
---
```

対応ツール:
- [agnix](https://www.npmjs.com/package/agnix) -- Agent Skills バリデーター
- [SkillsMP](https://skillsmp.com/) -- Agent Skills マーケットプレイス
- [SkillHub](https://www.skillhub.club/) -- スキル検索プラットフォーム

---

## コントリビューション

1. **学んだスキルを共有** -- 自分のClaude Codeセッションからパターンを抽出
2. **既存スキルを改善** -- 例を追加、説明を明確化
3. **問題を報告** -- 古くなった情報があれば教えてください

### スキルフォーマット

```markdown
---
name: your-skill-name
description: "Use when ... 簡潔な説明。"
license: MIT
metadata:
  author: your-github-username
  version: "1.0"
  extracted: "YYYY-MM-DD"
---

# スキルタイトル

**Extracted:** YYYY-MM-DD
**Context:** 問題コンテキストの簡潔な説明

## Problem
このスキルが解決する問題の明確な説明

## Solution
コード例を含む具体的な解決策

## When to Use
このスキルが適用される具体的なシナリオ
```

---

## ライセンス

MITライセンス -- 詳細は[LICENSE](LICENSE)ファイルを参照

---

**作成者:** [@shimo4228](https://github.com/shimo4228)
**最終更新:** 2026-02-14
