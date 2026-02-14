# スキル公開エコシステム構築計画

## Context

`shimo4228/claude-code-learned-skills` リポジトリ（24スキル収録済み）を Agent Skills 標準に準拠させ、GitHub およびマーケットプレイスから発見可能にする。さらに、定期的な棚卸しで新スキルを評価・収録する再現可能なワークフローを確立する。

### 用語定義

| 用語 | 意味 |
|------|------|
| **リポジトリ収録済み** | `claude-code-learned-skills` リポジトリに含まれているスキル（現在24件） |
| **learned skill** | Claude Code が `.claude/skills/learned/` に自動生成する学習済みスキル |
| **公開** | マーケットプレイスに登録され、第三者から発見・利用可能な状態 |

**重要**: 現時点ではマーケットプレイスには何も公開していない。リポジトリ収録 ≠ 公開。

### リポジトリ収録済みスキルの出自

グローバル (`~/.claude/skills/learned/`) および各プロジェクト (`.claude/skills/learned/`) の learned skills から、ECC (Everything Claude Code) 固有スキルを除外して収録したもの。

### 2つの世界の独立性

```
.claude/skills/learned/*.md     ← Claude Code が管理。フラット .md 必須。触らない。
claude-code-learned-skills/     ← 公開用リポジトリ。Agent Skills 標準で独自に構造化。
```

- learned フォルダはClaude Code の内部管理領域であり、フォーマット制約がある（フラット `.md`、`user-invocable` フィールド等）
- リポジトリ側は独立した公開用成果物であり、自由にフォーマットを変更できる
- learned → リポジトリは**一方通行のコピー＋変換**

### 現状の課題

- **フォーマット**: フラットな `.md` ファイル → SKILL.md 標準未準拠で各プラットフォームから不可視
- **未評価スキル**: プロジェクトレベルに20件の未評価 learned skills が存在
- **CI/CD**: なし
- **マーケットプレイス登録**: なし

---

## Phase 0: 前提確認（手戻り防止）

### Why

元計画は SkillsMP, SkillHub, agnix, skill-lab 等のツール・プラットフォームの存在を前提にしている。これらが実在しなければ Phase 3-4 の設計が空中楼閣になる。**実装前に確認することで手戻りを防ぐ**。

### 0-1. 確認項目

| 確認対象 | 確認方法 | フォールバック |
|---------|---------|-------------|
| Agent Skills 標準仕様 (`SKILL.md`) | Web検索 + 仕様書確認 | GitHub discoverable をゴールに切り替え |
| バリデーションツール (agnix, skill-lab) | `npm info agnix` / `pip install skill-lab` | 自前の YAML lint + markdown lint で代替 |
| SkillsMP | Web検索 + サイト確認 | GitHub Topics + awesome-list で代替 |
| SkillHub | Web検索 + サイト確認 | 同上 |

### 0-2. 成果物

- 確認結果一覧
- Phase 3-4 のスコープ確定（実在するプラットフォームのみ対象）

### 0-3. 判断基準

- 全て実在 → 計画通り進行
- 一部不在 → 該当部分をフォールバックに切り替え
- 全て不在 → 「GitHub で発見可能にする」にゴールを縮小（`skills/*/SKILL.md` 構造自体は GitHub での発見性を高めるので無駄にならない）

### 0-4. 確認結果（2026-02-14 実施）

**判定: 全て実在 → 計画通り進行**

| 確認対象 | 結果 | 詳細 |
|---------|------|------|
| Agent Skills 標準仕様 | **実在** | [agentskills.io/specification](https://agentskills.io/specification)。Anthropic が 2025年12月に公開。Microsoft, OpenAI, GitHub, Cursor 等が採用 |
| agnix | **実在** | npm パッケージ (v0.11.1)。SKILL.md 含む156ルールで検証 |
| skill-lab | **実在** | PyPI パッケージ。静的解析19チェック + トリガーテスト |
| skills-ref (公式) | **実在** | Python。`skills-ref validate ./my-skill`。デモ用途 |
| SkillsMP | **実在** | [skillsmp.com](https://skillsmp.com/)。GitHub 自動インデックス。星2以上が条件 |
| SkillHub | **実在** | [skillhub.club](https://www.skillhub.club/)。7,000+ スキル。LLM 5軸評価 |

**仕様の主要制約:**

- `name`: 1-64文字、小文字英数字+ハイフン、親ディレクトリ名と一致必須
- `description`: 1-1024文字。"Use when..." トリガー推奨
- SKILL.md 本文: 5000トークン以下・500行以下推奨
- `marketplace.json`: 任意（SkillsMP での検索性向上）
- SkillsMP 公開: `npm i -g agent-skills-cli` → `skills submit-repo owner/repo`

---

## Phase 1: リポジトリ収録済みスキルのフォーマット変換

### Why

現在の `global/**/*.md` / `projects/**/*.md` 構造は独自形式であり、Agent Skills 標準に準拠していない。標準化することで外部ツールやプラットフォームからの発見性が向上する。

### 1-1. ディレクトリ構造変換

```
# Before (現在)
global/python/python-immutable-accumulator.md

# After (Agent Skills標準)
skills/python-immutable-accumulator/SKILL.md
```

- `global/` と `projects/` のカテゴリ分類は README で維持（ディレクトリ構造ではなくドキュメントで表現）

### 1-2. frontmatter 変換ルール

```yaml
# Before (learned skill 形式)
---
name: python-immutable-accumulator
description: "Frozen dataclass + tuple accumulation pattern with slots gotcha."
user-invocable: false
---

# After (Agent Skills 標準)
---
name: python-immutable-accumulator
description: "Frozen dataclass + tuple accumulation pattern with __slots__ gotcha. Use when building immutable state accumulators in Python."
license: MIT
metadata:
  author: shimo4228
  version: "1.0"
  extracted: "2026-02-08"
---
```

変換ルール:
1. `user-invocable` → 削除（Agent Skills 仕様外）
2. `description` → "Use when ..." トリガーを末尾に追加（**手動**、自動化不可）
3. `license: MIT` → 追加
4. `metadata.author` → `shimo4228` 固定
5. `metadata.version` → `"1.0"` 初期値
6. `metadata.extracted` → 本文中の `Extracted:` 行から抽出。なければ現在日

### 1-3. 変換スクリプト (`scripts/migrate-format.sh`)

**入力**: learned skill の `.md` ファイルパス
**出力**: `skills/{name}/SKILL.md`

自動化する処理:
- frontmatter の解析・変換（上記ルール 1, 3, 4, 5, 6）
- ディレクトリ作成 + ファイル書き込み

自動化しない処理:
- description の "Use when..." リライト（文脈依存のため手動）

**Alternatives**: bash + sed/awk vs Python。Python の方が YAML パースが堅牢だが、依存を増やす。シンプルな frontmatter なので bash で十分。

### 1-4. README 更新

- 新ディレクトリ構造 (`skills/*/SKILL.md`) に合わせてリンク更新
- インストール手順を標準形式に更新
- Phase 0 の結果に応じて互換性バッジ追加

### 1-5. 成果物

- `skills/*/SKILL.md` (24件)
- `scripts/migrate-format.sh`
- 更新済み `README.md` / `README.ja.md`
- 旧 `global/` / `projects/` ディレクトリの削除

### 1-6. 実施メモ（2026-02-14）

**スクリプト作成 (Step 1)**:
- TDD (bats-core) で開発。22テスト全パス
- 当初の想定と異なり、24件中15件が frontmatter なしだった
- スクリプトを拡張: frontmatter なしファイルはファイル名から `name` を導出、`**Context:**` 行から `description` を抽出
- `--input` (単一ファイル) と `--batch` (ディレクトリ一括) の2モード対応

**フォーマット変換 (Step 2)**:
- 24/24 変換成功、エラー 0
- 全 name が Agent Skills 仕様に準拠済み（小文字英数字+ハイフン、1-64文字）

**agnix バリデーション (Step 2v)**:
- 7 errors: 全て偽陽性（バックスラッシュをWindowsパス区切りと誤検出）
- 24 warnings: 全て `Description should include a 'Use when...' trigger phrase`
- → description の "Use when..." 追加は手動対応（Step 2d、未着手）

**description "Use when..." 追加 (Step 2d)**:
- 24/24 description を "Use when..." 形式に更新
- 各スキルの本文 "When to Use" セクションを読み、frontmatter description に適切なトリガーフレーズを追記
- 全て英語で統一（元が日本語だったものも英語に変換）
- agnix 再バリデーション: 7 errors（偽陽性、変化なし）、**0 warnings**（24件の warning 解消）

---

## Phase 2: プロジェクト learned skills の評価・追加

### Why

各プロジェクトの `.claude/skills/learned/` に20件の未評価スキルがある。汎用性の高いものをリポジトリに追加することで、コレクションの価値を高める。

### 2-1. 対象

| プロジェクト | スキル数 | 場所 |
|------------|---------|------|
| pdf2anki | 9 | `pdf2anki/.claude/skills/learned/` |
| g-kentei-ios | 8 | `g-kentei-ios/.claude/skills/learned/` |
| gai-passport-ios | 3 | `gai-passport-ios/.claude/skills/learned/` |

### 2-2. 評価基準（4軸、各1-5点）

| 軸 | 基準 |
|----|------|
| **汎用性** | 他人のプロジェクトでも使えるか |
| **普遍性** | この問題に他の人も遭遇するか |
| **自己完結性** | 前提知識なしで理解できるか |
| **差別化** | 既存の収録済みスキルと被らないか |

判定:
- 16点以上 → 収録候補
- 12-15点 → 要改善（改善案付きで保留）
- 11点以下 → 収録しない

### 2-3. フロー

```
評価 → 結果一覧作成 → ユーザー承認 → 変換スクリプトで追加
```

- **ユーザー承認を必ず挟む**（勝手にリポジトリに追加しない）
- learned フォルダの元ファイルは一切触らない
- Phase 1 で作成した `scripts/migrate-format.sh` を再利用

### 2-4. 成果物

- 評価結果一覧（判定理由付き）
- 承認されたスキルの `skills/*/SKILL.md`

### 2-5. 実施メモ（2026-02-14）

**評価 (Step 4)**:
- 20件を4軸評価（汎用性・普遍性・自己完結性・差別化、各1-5点）
- 結果: 収録候補15件（16点以上）、要改善3件、除外2件
- 最高スコア: cost-aware-llm-pipeline (19点)
- 新言語: Swift (5件), Python (8件), 言語非依存 (2件)

**ユーザー承認 (Step 5)**:
- 全15件の収録を承認
- 要改善3件は保留（claude-vision-multimodal-pipeline, irregular-japanese-text-parsing, pymupdf-mock-testing）
- 除外2件確定（g-kentei-ocr-text-normalization, questions-json-structure）

**変換 (Step 5)**:
- `scripts/migrate-format.sh` で15件を一括変換
- "Use when..." トリガーフレーズを追加
- 合計39スキル（24既存 + 15新規）

---

## Phase 3: CI/CD & バリデーション

### Why

手動検証は漏れが出る。PR/push 時に自動検証することでフォーマット違反を防ぐ。

### 3-1. GitHub Actions ワークフロー

`.github/workflows/validate-skills.yml`:
- PR/push 時に自動検証
- マークダウンリンク切れチェック
- バリデーションツールは Phase 0 の結果に応じて選定

### 3-2. GitHub リポジトリ設定

トピック追加: `claude-code-skills`, `agent-skills`, `claude-skills`, `codex-skills`

### 3-3. 成果物

- `.github/workflows/validate-skills.yml`
- GitHub トピック設定

---

## Phase 4: マーケットプレイス公開

### Why

GitHub だけでは発見性が限定的。マーケットプレイスに登録することで、スキルを探している開発者にリーチできる。

### 4-1. スコープ（Phase 0 の結果で確定）

Phase 0 で実在が確認されたプラットフォームのみ対象。

**実在した場合:**
- SkillsMP → `skills submit-repo` で投稿
- SkillHub → SKILL.md 準拠で自動インデックス

**不在だった場合（フォールバック）:**
- GitHub Topics による発見性確保
- awesome-lists への PR（スター蓄積後）
  - awesome-claude-code 等

### 4-2. 成果物

- マーケットプレイス登録完了（または フォールバック施策の実行）

---

## Phase 5: 再現可能ワークフローの文書化

### Why

スキルの棚卸し・評価・変換・公開は今後も繰り返す作業。手順を文書化することで、毎回ゼロから考える必要がなくなる。

### 5-1. `docs/PUBLISHING.md` 作成

```
1. INVENTORY（棚卸し）
   - ~/.claude/skills/learned/ と各プロジェクトの .claude/skills/learned/ を走査
   - 既存の収録済みスキルと重複がないか確認
   - 新規スキルを4軸で評価

2. FORMAT（変換）
   - scripts/migrate-format.sh で変換
   - description の "Use when..." トリガーを手動追記
   - README のスキル一覧に追加

3. VALIDATE（検証）
   - ローカル: Phase 0 で確定したツールで検証
   - CI: push 時に自動検証

4. PUBLISH（公開）
   - git push → CI 通過確認
   - マーケットプレイスへの登録（該当する場合）

5. REVIEW（振り返り）
   - 四半期ごとの全スキルレビュー
   - 陳腐化したスキルの更新・削除
```

### 5-2. トリガー条件

| トリガー | アクション |
|---------|-----------|
| learned/ に新スキル5件蓄積 | 棚卸し実施 |
| 棚卸しで収録候補あり | Phase 2 の評価フロー実行 |
| 四半期 | 全スキルレビュー |

### 5-3. 成果物

- `docs/PUBLISHING.md`

---

## 実行順序と進捗

| Step | 内容 | 依存 | 成果物 | 状態 |
|------|------|------|--------|------|
| 0 | 前提確認（ツール・プラットフォーム実在性） | なし | 確認結果、Phase 3-4 スコープ確定 | **完了** |
| 1 | 変換スクリプト作成 | なし | `scripts/migrate-format.sh` | **完了** (TDD: 22テスト) |
| 2 | 収録済み24件のフォーマット変換 | Step 1 | `skills/*/SKILL.md` | **完了** (24/24変換済) |
| 2v | agnix バリデーション | Step 2 | バリデーション結果 | **完了** (7偽陽性error, 24 warning) |
| 2d | description に "Use when..." 追加 | Step 2v | 更新済み description | **完了** (24/24更新, 0 warning) |
| 3 | README 更新 | Step 2 | `README.md`, `README.ja.md` | **完了** (39スキル7カテゴリに全面更新) |
| 4 | プロジェクト learned skills の評価 | なし | 評価結果一覧 | **完了** (20件評価: 15収録/3保留/2除外) |
| 5 | 評価結果のユーザー承認 → 追加変換 | Step 1, 4 | 追加の `skills/*/SKILL.md` | **完了** (15件変換, 合計39スキル) |
| 6 | CI/CD 設定 | Step 0, 2 | `.github/workflows/validate-skills.yml` | **完了** (frontmatter検証 + リンクチェック) |
| 7 | GitHub トピック追加・push | Step 3, 6 | 4トピック設定、51ファイル push | **完了** |
| 8 | マーケットプレイス公開 | Step 0, 7 | SkillsMP: 39件登録済, SkillHub: 自動インデックス待ち | **完了** |
| 9 | `docs/PUBLISHING.md` 作成 | Step 0-8 の経験を反映 | `docs/PUBLISHING.md` | 未着手 |

**並列実行可能**: Step 0 と Step 1 は独立。Step 4 は Step 2 と並列可能。

---

## 対象ファイル

### 変換対象（入力）

- `global/**/*.md` (18ファイル)
- `projects/zenn-content/*.md` (6ファイル)
- 各プロジェクトの `.claude/skills/learned/*.md` (20ファイル、評価後に選別)

### 生成・更新（出力）

- `skills/*/SKILL.md` → 新規作成（24件 + 評価通過分）
- `scripts/migrate-format.sh` → 新規作成
- `README.md` → 更新
- `README.ja.md` → 更新
- `.github/workflows/validate-skills.yml` → 新規作成
- `docs/PUBLISHING.md` → 新規作成

### 削除

- `global/` → `skills/` への移行完了後に削除
- `projects/` → `skills/` への移行完了後に削除

---

## 検証方法

1. **フォーマット変換後**: Phase 0 で確定したバリデーションツールで検証
2. **CI**: GitHub Actions が緑になることを確認
3. **マーケットプレイス**: 投稿後にリポジトリが検索可能になることを確認（該当する場合）
4. **クロスプラットフォーム**: Codex CLI 等で `SKILL.md` が認識されることを確認（手動）

---

## リスクと対策

| リスク | 影響 | 対策 |
|--------|------|------|
| マーケットプレイスが存在しない | Phase 4 が実行不可 | Phase 0 で検出。GitHub Topics で代替 |
| Agent Skills 標準仕様が変更される | フォーマット再変換が必要 | 変換スクリプトがあるので再実行可能 |
| learned skill の元ファイルが更新される | リポジトリ側が古くなる | PUBLISHING.md のワークフローで定期同期 |
| description の "Use when..." が不適切 | スキルの発見性が低下 | Phase 5 のレビューサイクルで改善 |
