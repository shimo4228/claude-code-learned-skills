# Claude Code Learned Skills

> 実際のClaude Code使用経験から学んだ実践的なパターンとベストプラクティス集

このリポジトリには、実際のClaude Code開発セッションから抽出された**24個の実戦スキル**が含まれています。**グローバル**（クロスプロジェクト）と**プロジェクト固有**のコレクションに整理されています。

[English](README.md) | **日本語**

## ディレクトリ構成

```
├── global/                    # クロスプロジェクトスキル (~/.claude/skills/learned/)
│   ├── architecture/          # システム設計パターン
│   ├── claude-code/           # Claude Code操作パターン
│   ├── llm/                   # LLM統合パターン
│   ├── process/               # 開発プロセスパターン
│   └── python/                # Python固有パターン
└── projects/                  # プロジェクト固有スキル (.claude/skills/learned/)
    └── zenn-content/          # Zenn記事執筆パターン
```

---

## グローバルスキル (18)

`~/.claude/skills/learned/` にインストール。全プロジェクトで利用可能。

### アーキテクチャ (2)

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [AI Era Architecture Principles](global/architecture/ai-era-architecture-principles.md) | 従来のアーキテクチャパターンがAIアプリに適合しない | マイクロ依存原則、LLM組み込み可能性、コンテキストウィンドウ最適化 |
| [Service Layer Extraction](global/architecture/service-layer-extraction.md) | CLIモジュールがビジネスロジックとUIを混在 | Typer/Click CLIからテスト可能なサービス層を抽出 |

### Claude Code (7)

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [Claude Code Tool Patterns](global/claude-code/claude-code-tool-patterns.md) | 大ファイル書込み性能、Edit更新エラー、Hook JSONエスケープ | Claude Codeツール操作の落とし穴集 |
| [Claude Code Self-Generation over API](global/claude-code/claude-code-self-generation-over-api.md) | Claude Code自身で生成できるのに外部APIを呼ぶ | 外部APIより先にClaude Codeの組込みLLM能力を検討 |
| [Claude Code MCP Manual Install](global/claude-code/claude-code-mcp-manual-install.md) | MCP CLIインストーラがセッション内で使えない | `~/.claude.json` mcpServersの手動JSON編集 |
| [Parallel Subagent Batch Merge](global/claude-code/parallel-subagent-batch-merge.md) | 逐次データ生成が遅い | 並列サブエージェントバッチ生成とマルチフォーマットマージ |
| [Skill Stocktaking Process](global/claude-code/skill-stocktaking-process.md) | スキルがレビューなしに蓄積しCharacter Budgetに到達 | 4ステップ統廃合、3層組織、タイミングトリガー |
| [Directory Structure Enforcement Hooks](global/claude-code/directory-structure-enforcement-hooks.md) | ファイルが間違ったディレクトリに配置される | Claude Codeフックでディレクトリ構造ルールを自動強制 |
| [Cross-Source Fact Verification](global/claude-code/cross-source-fact-verification.md) | ドラフト記事に日付・数値・順序の誤り | デバッグログ・MEMORY・git・タイムスタンプの5段階クロス検証 |

### LLM (3)

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [CJK-Aware Text Metrics](global/llm/cjk-aware-text-metrics.md) | CJK/Latin混在テキストのトークン数推定が不正確 | 多言語LLMパイプライン向け加重推定式 |
| [Data Generation Quality Metrics Loop](global/llm/data-generation-quality-metrics-loop.md) | 自動生成データの品質が不安定 | 定量メトリクスによる反復改善ループ |
| [Deep Research API Landscape](global/llm/deep-research-api-landscape.md) | ディープリサーチ自動化にPlaywrightを使おうとする | 主要3社が公式Deep Research APIを提供（2026年） |

### プロセス (3)

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [Root Cause Challenge Pattern](global/process/root-cause-challenge-pattern.md) | 表面的な修正で根本原因を見つけない | 5段階意思決定フレームワーク：複雑さを増す前に前提を疑う |
| [Brainstorming Communication](global/process/brainstorming-communication.md) | AIがアイデア検討段階で早々に具体的解決策を提示 | アイデア探索フェーズと実装フェーズのコミュニケーションプロトコル |
| [JSON Data Validation Test Design](global/process/json-data-validation-test-design.md) | 大規模JSONデータファイルにバリデーションがない | スキーマ・ソースデータ・ビジネスルールのバリデーションテスト設計 |

### Python (3)

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [Python Immutable Accumulator](global/python/python-immutable-accumulator.md) | ミューテーションなしで結果を蓄積したい | frozen dataclass + tuple蓄積パターン（`__slots__`の罠付き） |
| [Python Optional Dependencies](global/python/python-optional-dependencies.md) | 使わない重い依存をユーザーに強制したくない | pyproject.toml extras、ランタイムチェック、ファクトリパターン |
| [Python Module-to-Package Refactor](global/python/python-module-to-package-refactor.md) | 単一モジュールが肥大化 | モジュール→パッケージリファクタリング（`mock.patch`ターゲット更新付き） |

---

## プロジェクト固有スキル (6)

各プロジェクトの `.claude/skills/learned/` にインストール。

### zenn-content (6)

Zenn/Qiita技術記事執筆に特化したパターン。

| スキル | 課題 | 解決策 |
|--------|------|--------|
| [Tech Writing Patterns](projects/zenn-content/tech-writing-patterns.md) | 記事の品質やトーンが不安定 | クロスポスト、トーン調整、技術記事品質パターン |
| [Zenn Context-Driven Writing](projects/zenn-content/zenn-context-driven-writing.md) | 構造化された準備なしに記事を書く | ドラフト前のコンテキスト収集・構造化ワークフロー |
| [Zenn-Qiita Crosspost Workflow](projects/zenn-content/zenn-qiita-crosspost-workflow.md) | 手動クロスポストがエラーを起こしやすい | フォーマットマッピング付き自動Zenn→Qiita変換 |
| [prh Hyphen Regex Escape](projects/zenn-content/prh-hyphen-regex-escape.md) | Node.js 20+でprh.ymlのハイフンパターンがエラー | prh.ymlでハイフン含むパターンを避ける |
| [Zenn markdownlint Config](projects/zenn-content/zenn-markdownlint-config.md) | デフォルトmarkdownlintルールがZenn構文と衝突 | MD025/MD041/MD060/MD013を無効化、configにglob不可 |
| [Zenn textlint Workarounds](projects/zenn-content/zenn-textlint-workarounds.md) | Zenn固有構文でtextlintが誤検出 | Zenn記事向けの既知の誤検出と回避策 |

---

## 使用方法

### グローバルスキルのインストール

```bash
# 全グローバルスキルをコピー（カテゴリ構造を維持）
cp -r global/*/ ~/.claude/skills/learned/

# 個別スキルをコピー
cp global/python/python-immutable-accumulator.md ~/.claude/skills/learned/
```

### プロジェクトスキルのインストール

```bash
# プロジェクト固有スキルをコピー
cp -r projects/zenn-content/ your-project/.claude/skills/learned/
```

---

## コントリビューション

1. **学んだスキルを共有** — 自分のClaude Codeセッションからパターンを抽出
2. **既存スキルを改善** — 例を追加、説明を明確化
3. **新しいプロジェクトを追加** — `projects/your-project/` を作成

### スキルフォーマット

```markdown
# スキル名

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

MITライセンス — 詳細は[LICENSE](LICENSE)ファイルを参照

---

**作成者:** [@shimo4228](https://github.com/shimo4228)
**最終更新:** 2026-02-14
