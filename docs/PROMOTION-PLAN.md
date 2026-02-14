# オーセンシティ向上計画：コミュニティ貢献を軸に

## Context

39スキルを SkillsMP / SkillHub に公開済みだが、ダウンロード数・レピュテーションの仕組みがない。マーケットプレイスは「検索ディレクトリ」に過ぎず、それだけではオーセンシティに繋がらない。

**狙い**: スキルを「自分のリポジトリに置いて終わり」ではなく、コミュニティの中に届けることで、著者としての認知と信頼を積み上げる。

---

## 調査結果サマリ（2026-02-14 時点）

| 貢献先 | Stars | 特徴 | PR マージ率 |
|--------|-------|------|------------|
| [anthropics/skills](https://github.com/anthropics/skills) | 69K | 公式16スキルのみ。Anthropic 社員のみマージ | 極めて低い |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) (ECC) | 46K | コミュニティ歓迎。詳細な PR テンプレあり | 高い |
| [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | 7K | 339+スキルの最大キュレーションリスト | 中（実績要求あり） |
| [agentskills/agentskills](https://github.com/agentskills/agentskills) | 10K | Agent Skills 仕様そのもの | 不明 |

**判断**: anthropics/skills は社内ゲートが固く ROI が低い。**ECC と awesome-agent-skills を主軸**に、ブログ発信で補強する。

---

## Phase A: ECC への PR（最優先）

### Why

- 46K スターの巨大コミュニティ、PR テンプレートも整備済み
- 現在 Swift / iOS スキルが**ゼロ** → 差別化できるブルーオーシャン
- マージされれば GitHub の contributor バッジがつく

### What

ECC にない分野から **3-5スキルを厳選して PR**:

| 候補スキル | 理由 |
|-----------|------|
| `cost-aware-llm-pipeline` | ECC にコスト最適化スキルなし。LLM 全般に需要高 |
| `protocol-di-testing` | Swift テスト手法。ECC は "Language-specific" を明示的に募集中 |
| `swift-actor-persistence` | Swift 並行処理。モバイル開発者に訴求 |
| `content-hash-cache-pattern` | 汎用キャッシュパターン。Python ユーザー全般に有用 |
| `regex-vs-llm-structured-text` | LLM vs 従来手法の判断基準。実践的で差別化 |

### How

1. ECC を fork
2. `skills/` に SKILL.md を追加（ECC のフォーマットに合わせる）
3. PR テンプレートに従って提出
4. 1 PR = 1 スキル（レビューしやすく）

### Alternative

一括 PR で「Swift / iOS カテゴリ」を提案する方法もあるが、レビュー負荷が高く却下リスクも上がるため、1件ずつが安全。

---

## Phase B: awesome-agent-skills への掲載

### Why

- 7K スター、Agent Skills の事実上の「公式カタログ」
- "Community Skills" セクションに掲載されれば、最大の発見性

### What

リポジトリ `shimo4228/claude-code-learned-skills` を Community Skills セクションに追加する PR を提出。

### 注意

README に明記あり: **"Please don't submit skills you created 3 hours ago. We're now focusing on community-adopted skills."** → Phase A の ECC マージや GitHub スター（目安: 10+）を先に積んでから提出する。

### How

1. Phase A 完了後（ECC マージ実績あり）
2. リポジトリのスターが 10+ になったタイミングで PR
3. 全39スキルではなく、**最も汎用的な 5-8 スキル**をピックアップして掲載依頼

---

## Phase C: Zenn 記事（発信・認知拡大）

### Why

- 日本語圏の Agent Skills 情報はまだ少ない → 先行者優位
- 技術記事は Google 検索経由で長期的に流入を生む
- Zenn/Qiita の既存ワークフロー（`zenn-qiita-crosspost-workflow`）を活用可能

### What

**記事案1: 「Agent Skills 入門」（エコシステム解説）**
- Agent Skills 仕様、マーケットプレイス、ツール群の全体像
- 日本語で体系的に解説した記事は現時点でほぼない
- 自リポジトリを実例として紹介

**記事案2: 「learned skills を公開するまでの全工程」（実践記）**
- PUBLISHING-PLAN.md の実体験をベースに
- 棚卸し → 4軸評価 → 変換 → CI → マーケットプレイス登録
- 再現可能なワークフローとして価値が高い

**記事案3: 「Claude Code × Swift 開発」（技術ニッチ）**
- Swift/iOS 開発で Claude Code を使うパターン集
- protocol-di-testing, swift-actor-persistence 等を具体例に
- モバイル × AI エージェントの交差点はまだ記事が少ない

### How

- 記事1 を最初に公開（最も広いリーチ）
- 記事2, 3 は Phase A の進捗に合わせて順次

---

## Phase D: agentskills/agentskills 仕様への貢献（長期）

### Why

- 仕様そのものへの貢献は最も強いオーセンシティ
- 10K スターの公式標準リポジトリ

### What

実運用で見つけた改善点を Issue / PR で提案:
- 例: `metadata.author` を配列対応にする（共著スキル対応）
- 例: `metadata.tags` フィールドの標準化（カテゴリ検索改善）
- 例: agnix の偽陽性（バックスラッシュ誤検出）の Issue 報告

### 注意

仕様への PR はハードルが高い。まず Issue で議論 → 賛同を得てから PR が現実的。

---

## 実行順序

```
Phase A: ECC への PR (3-5件)
  ↓ マージ実績を積む
Phase B: awesome-agent-skills への掲載 PR
  ↓ 並行して
Phase C: Zenn 記事（記事1 → 記事2 → 記事3）
  ↓ 長期
Phase D: agentskills 仕様への Issue/PR
```

Phase A と C-1 は並行実行可能。

---

## 進捗

| Phase | 内容 | 状態 |
|-------|------|------|
| A | ECC への PR (3-5件) | 未着手 |
| B | awesome-agent-skills への掲載 | 未着手（Phase A 後） |
| C-1 | Zenn 記事: Agent Skills 入門 | 未着手 |
| C-2 | Zenn 記事: learned skills 公開全工程 | 未着手 |
| C-3 | Zenn 記事: Claude Code × Swift | 未着手 |
| D | agentskills 仕様への貢献 | 未着手（長期） |

## 検証方法

- [ ] ECC の PR がマージされ、contributor として表示される
- [ ] awesome-agent-skills に掲載される
- [ ] Zenn 記事の PV / いいね / ストック数
- [ ] GitHub リポジトリのスター増加
- [ ] SkillsMP / SkillHub でのスキル表示確認
