# スキル公開ワークフロー

新しい learned skills を評価・変換・公開するための再現可能な手順書。

---

## 1. INVENTORY（棚卸し）

### 対象の走査

```bash
# グローバル learned skills
ls ~/.claude/skills/learned/

# プロジェクト learned skills（各プロジェクトで実行）
ls .claude/skills/learned/
```

### 重複チェック

```bash
# 既存スキル名の一覧
ls skills/ | sort > /tmp/existing.txt

# 新規候補の名前（ファイル名から拡張子除去）
ls ~/.claude/skills/learned/ | sed 's/\.md$//' | sort > /tmp/candidates.txt

# 重複確認
comm -12 /tmp/existing.txt /tmp/candidates.txt
```

### 4軸評価（各1-5点、合計20点満点）

| 軸 | 基準 |
|----|------|
| **汎用性** | 他人のプロジェクトでも使えるか |
| **普遍性** | この問題に他の人も遭遇するか |
| **自己完結性** | 前提知識なしで理解できるか |
| **差別化** | 既存の収録済みスキルと被らないか |

判定:
- **16点以上** → 収録候補
- **12-15点** → 要改善（改善案付きで保留）
- **11点以下** → 収録しない

> 評価結果はユーザー承認を必ず挟む。勝手にリポジトリに追加しない。

---

## 2. FORMAT（変換）

### 変換スクリプトの実行

```bash
# 単一ファイル
scripts/migrate-format.sh \
  --input ~/.claude/skills/learned/my-skill.md \
  --output-dir skills

# 一括変換
scripts/migrate-format.sh \
  --batch ~/.claude/skills/learned/ \
  --output-dir skills
```

スクリプトが自動処理すること:
- `user-invocable` フィールドの除去
- `license: MIT` の追加
- `metadata.author`, `metadata.version`, `metadata.extracted` の追加
- `skills/{name}/SKILL.md` 構造への配置

### "Use when..." トリガーの追記（手動）

各スキルの `description` に "Use when..." トリガーフレーズを追加する。これは文脈依存のため自動化不可。

```yaml
# Before
description: "SHA-256 content-hash keying with frozen CacheEntry."

# After
description: "Use when caching expensive file processing results. SHA-256 content-hash keying with frozen CacheEntry."
```

ルール:
- 英語で統一（元が日本語でも英語に変換）
- スキル本文の "When to Use" セクションを参考にする
- 簡潔に（1-2文）

### README への追加

`README.md` と `README.ja.md` のスキル一覧テーブルに新スキルを追加する。

カテゴリ: Architecture, Claude Code, LLM, Process, Python, Swift / iOS, Tech Writing (Zenn/Qiita)

更新箇所:
1. ヘッダーのスキル総数
2. 該当カテゴリのテーブルに行追加（アルファベット順）
3. 日本語版にも同じ変更を反映

---

## 3. VALIDATE（検証）

### ローカル検証

```bash
# agnix バリデーション（npm パッケージ）
npx agnix validate skills/my-skill/SKILL.md

# 全スキル一括
for d in skills/*/; do npx agnix validate "$d/SKILL.md"; done
```

既知の偽陽性:
- バックスラッシュ (`\-`, `\"` 等) を Windows パス区切りと誤検出 → 無視可

### CI 検証（GitHub Actions）

`.github/workflows/validate-skills.yml` が push/PR 時に自動実行:
- frontmatter 必須フィールド (`name`, `description`, `license`) の存在確認
- `name` とディレクトリ名の一致確認
- `description` に "Use when" トリガーの存在確認
- README 内のスキルリンク切れチェック

### リンクチェック

```bash
# README のスキルリンクを全件検証
for link in $(grep -oE '\]\(skills/[^)]+\)' README.md | awk '{gsub(/^\]\(|\)$/, ""); print}'); do
  [ -f "$link" ] || echo "BROKEN: $link"
done
```

---

## 4. PUBLISH（公開）

### Git push

```bash
git add skills/ README.md README.ja.md
git commit -m "feat: add N new skills (skill-name-1, skill-name-2, ...)"
git push origin main
```

CI が緑になることを確認。

### SkillsMP 登録

```bash
npx agent-skills-cli submit-repo shimo4228/claude-code-learned-skills
```

登録確認:

```bash
npx agent-skills-cli search shimo4228
```

### SkillHub

SKILL.md 準拠 + GitHub トピック設定済みであれば自動インデックスされる。処理に数時間〜数日かかる場合あり。

---

## 5. REVIEW（振り返り）

### トリガー条件

| トリガー | アクション |
|---------|-----------|
| learned/ に新スキル5件蓄積 | このワークフローの INVENTORY から実行 |
| 棚卸しで収録候補あり | ユーザー承認 → FORMAT から実行 |
| 四半期 | 全スキルレビュー（下記） |

### 四半期レビュー

確認項目:
- [ ] 陳腐化したスキルの有無（ツールのバージョンアップで不要になった等）
- [ ] description の "Use when..." が実態と合っているか
- [ ] README のカテゴリ分類が適切か
- [ ] CI が正常に動作しているか

---

## ツール一覧

| ツール | 用途 | インストール |
|--------|------|-------------|
| `scripts/migrate-format.sh` | learned skill → Agent Skills 標準変換 | リポジトリ内 |
| [agnix](https://www.npmjs.com/package/agnix) | SKILL.md バリデーション | `npm i -g agnix` |
| [agent-skills-cli](https://www.npmjs.com/package/agent-skills-cli) | マーケットプレイス登録・検索 | `npx agent-skills-cli` |

## プラットフォーム

| プラットフォーム | URL | 登録方式 |
|----------------|-----|---------|
| SkillsMP | [skillsmp.com](https://skillsmp.com/) | `skills submit-repo` で明示的に登録 |
| SkillHub | [skillhub.club](https://www.skillhub.club/) | SKILL.md 準拠で GitHub から自動インデックス |

## 注意事項

- learned フォルダ (`~/.claude/skills/learned/`) の元ファイルは一切触らない
- learned → リポジトリは一方通行のコピー＋変換
- macOS で検証する場合、BSD sed/head/grep の挙動差に注意（`head -n -1` 不可、`awk` で代替）
