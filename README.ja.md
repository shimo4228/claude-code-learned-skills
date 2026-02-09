# Claude Code Learned Skills

> 実際のClaude Code使用経験から学んだ実践的なパターンとベストプラクティス集

このリポジトリには、実際のClaude Code開発セッションから抽出された、実戦で使える15個のスキルが含まれています。各スキルは、AI支援ソフトウェア開発における一般的な課題に対する実証済みの解決策を提供します。

[English](README.md) | **日本語**

## 📚 カテゴリ

- [🛠️ Claude Code パターン](#️-claude-code-パターン) - Claude Code操作パターン
- [🏗️ アーキテクチャパターン](#️-アーキテクチャパターン) - システム設計パターン
- [🐍 Python パターン](#-python-パターン) - Python特有のパターン
- [🦅 Swift パターン](#-swift-パターン) - Swift特有のパターン
- [🤖 LLM統合パターン](#-llm統合パターン) - LLM活用パターン
- [⚙️ 開発プロセス](#️-開発プロセス) - 開発ワークフロー

---

## 🛠️ Claude Code パターン

効果的なClaude Code使用とツール操作のためのパターン。

### [File Edit Refresh Pattern](claude-code/file-edit-refresh-pattern.md)
**課題:** Edit操作中に「File has been modified since read」エラーが発生する
**解決策:** Editの前に必ずReadでファイル内容を更新する（特に長時間セッション時）

```python
# パターン
1. Read(file_path)        # 現在の状態を更新
2. Edit(file_path, ...)   # 安全に編集可能
```

**使用時期:** 複数のファイル操作を含むセッションで、すべてのEdit呼び出しの前

### [Large File Write Performance](claude-code/large-file-write-performance.md)
**課題:** 大きなファイルを書き込む際のパフォーマンスが遅い
**解決策:** 大きなファイル処理のためにWrite操作を最適化

**使用時期:** 通常のコードファイルよりも大きなファイルを扱う場合

---

## 🏗️ アーキテクチャパターン

システム設計とアーキテクチャ意思決定のためのパターン。

### [AI Era Architecture Principles](architecture/ai-era-architecture-principles.md)
**課題:** 従来のアーキテクチャパターンはAI搭載アプリケーションに適合しない
**解決策:** LLM統合システム専用に設計されたアーキテクチャ原則

**主要原則:**
- LLM組み込み可能性を考慮した設計
- コンテキストウィンドウ制約の最適化
- プロンプトエンジニアリングを考慮した構造
- 非決定的動作への対応計画

### [Protocol DI Testing](architecture/protocol-di-testing.md)
**課題:** 外部依存との密結合によりコードのテストが困難
**解決策:** Protocol（ダックタイピング）を使用した依存性注入と簡単なモック作成

```python
from typing import Protocol

class Repository(Protocol):
    def find_by_id(self, id: str) -> dict | None: ...
    def save(self, entity: dict) -> dict: ...
```

**メリット:** テスト容易性の向上、疎結合、明確な契約

### [Backward Compatible Frozen Extension](architecture/backward-compatible-frozen-extension.md)
**課題:** 既存コードを壊さずにイミュータブルなdataclassを拡張する必要がある
**解決策:** 後方互換性を維持しながらfrozen dataclassを拡張

**使用時期:** 本番システムでイミュータブルなデータモデルを進化させる場合

---

## 🐍 Python パターン

Python固有のイディオムとベストプラクティス。

### [Immutable Model Updates](python/immutable-model-updates.md)
**課題:** ミューテーションが隠れた副作用やデバッグ困難な問題を引き起こす
**解決策:** dataclassと型安全性を使ったイミュータブルパターン

```python
from dataclasses import dataclass, replace

@dataclass(frozen=True)
class User:
    name: str
    email: str

# イミュータブルな更新
updated_user = replace(user, email="new@example.com")
```

**メリット:** 副作用なし、デバッグ容易、安全な並行処理

### [Python Immutable Accumulator](python/python-immutable-accumulator.md)
**課題:** ミューテーションなしで結果を蓄積する必要がある
**解決策:** Pythonでの関数型アキュムレーションパターン

**使用時期:** データ変換、集約、パイプライン処理

### [Python Optional Dependencies](python/python-optional-dependencies.md)
**課題:** 使わないかもしれない重い依存関係をユーザーにインストールさせたくない
**解決策:** オプショナル依存関係を適切に処理し、グレースフルデグラデーション

```python
try:
    import expensive_lib
    HAS_EXPENSIVE = True
except ImportError:
    HAS_EXPENSIVE = False

def feature_requiring_lib():
    if not HAS_EXPENSIVE:
        raise ImportError("Install with: pip install package[extra]")
```

---

## 🦅 Swift パターン

iOS/macOS開発のためのSwift固有のパターン。

### [Swift Actor Persistence](swift/swift-actor-persistence.md)
**課題:** Swift並行環境でのスレッドセーフなデータ永続化
**解決策:** 安全な並行データアクセスと永続化のためのActorパターン

```swift
actor DataStore {
    private var cache: [String: Data] = [:]

    func save(_ data: Data, for key: String) async {
        cache[key] = data
        // ディスクに永続化
    }
}
```

**メリット:** スレッド安全性、データ競合防止、クリーンな並行処理モデル

---

## 🤖 LLM統合パターン

大規模言語モデルをアプリケーションに統合するためのパターン。

### [Cost-Aware LLM Pipeline](llm/cost-aware-llm-pipeline.md)
**課題:** LLM APIコストが制御不能になる可能性がある
**解決策:** コスト最適化を第一級の関心事として設計されたパイプライン

**戦略:**
- シンプルなタスクには安価なモデルを使用
- 積極的に結果をキャッシュ
- リクエストのバッチ処理を実装
- コストしきい値の監視とアラート

### [Long Document LLM Pipeline](llm/long-document-llm-pipeline.md)
**課題:** ドキュメントがLLMコンテキストウィンドウの制限を超える
**解決策:** 長いドキュメントを処理するための多段階パイプライン

**アプローチ:**
1. ドキュメントをインテリジェントにチャンク分割
2. コンテキストオーバーラップでチャンクを処理
3. 要約パスで結果を集約
4. 最終的な統合

### [Regex vs LLM Structured Text](llm/regex-vs-llm-structured-text.md)
**課題:** テキスト抽出に正規表現とLLMのどちらを使うべきか
**解決策:** 適切なツールを選択するための意思決定フレームワーク

| パターン | 正規表現を使う | LLMを使う |
|---------|-----------|---------|
| 固定フォーマット | ✅ 高速・確実 | ❌ やりすぎ |
| 可変フォーマット | ❌ 脆弱 | ✅ 柔軟 |
| 意味理解が必要 | ❌ 不可能 | ✅ 自然 |
| コスト重視 | ✅ 無料 | ❌ 従量課金 |

---

## ⚙️ 開発プロセス

開発のためのワークフローとプロセスパターン。

### [Algorithm Migration with Rollback](process/algorithm-migration-with-rollback.md)
**課題:** 本番環境で重要なアルゴリズムを置き換えるのはリスクが高い
**解決策:** A/B比較とロールバック機能を持つフィーチャーフラグシステムの実装

```python
def process_data(data, use_new_algorithm=False):
    if use_new_algorithm:
        return new_algorithm(data)
    else:
        return legacy_algorithm(data)
```

**手順:** フィーチャーフラグ → 並行実行 → 結果比較 → 段階的ロールアウト → 完全移行

### [Root Cause Challenge Pattern](process/root-cause-challenge-pattern.md)
**課題:** 表面的な修正で止まってしまい、根本原因を見つけない
**解決策:** 「なぜなぜ分析」による体系的な根本原因分析

**プロセス:**
1. 問題を明確化
2. 原因を見つけるために「なぜ？」と問う
3. 各回答に対して「なぜ？」を繰り返す（通常5回）
4. 根本原因を特定
5. 根本レベルで修正

### [Skill Stocktaking Process](process/skill-stocktaking-process.md)
**課題:** 学んだパターンが忘れられ、再利用されない
**解決策:** 学んだパターンの定期的なレビューとドキュメント化

**ワークフロー:**
1. 週次でセッションをレビュー
2. 再利用可能なパターンを抽出
3. スキルとしてドキュメント化
4. ワークフローに統合
5. チームと共有

---

## 🚀 使用方法

### スキルのインストール

各スキルは参照ドキュメントとして使用するか、Claude Codeセットアップに統合できます：

```bash
# 個別のスキルをClaude Codeスキルディレクトリにコピー
cp python/immutable-model-updates.md ~/.claude/skills/learned/

# またはカテゴリ全体をコピー
cp -r python/* ~/.claude/skills/learned/
```

### Claude Codeでのスキル使用

スキルはClaude Codeで作業する際に自動的に利用可能になります。会話の中で名前で参照できます：

```
ユーザー: "このdataclassをミューテーションなしで更新したい"
Claude: [immutable-model-updatesスキルを参照]
```

---

## 🤝 コントリビューション

これらのスキルは実際の開発セッションから抽出されました。コントリビューション歓迎です！

### コントリビュート方法

1. **学んだスキルを共有** - 自分のClaude Codeセッションからパターンを抽出
2. **既存スキルを改善** - 例を追加、説明を明確化、エラーを修正
3. **新しいカテゴリを追加** - 整理のための新しいスキルカテゴリを提案

### スキルフォーマット

各スキルは以下の構造に従ってください：

```markdown
# スキル名

**抽出日:** YYYY-MM-DD
**コンテキスト:** 問題コンテキストの簡潔な説明

## 課題

このスキルが解決する問題の明確な説明

## 解決策

コード例を含む具体的な解決策

## 使用時期

このスキルが適用される具体的なシナリオ

## 関連パターン

関連するスキルへのリンク
```

---

## 📝 ライセンス

MITライセンス - 詳細は[LICENSE](LICENSE)ファイルを参照

---

## 🙏 謝辞

- [Claude Code](https://claude.ai/claude-code)で作成
- 継続的学習パターンを使用して抽出
- 実際の開発課題から着想

---

## 📖 詳細情報

- [Claude Code ドキュメント](https://docs.anthropic.com/claude/docs/claude-code)
- [Everything Claude Code (ECC)](https://github.com/anthropics/claude-code) - コミュニティパターンと設定

---

**作成者:** [@shimomoto_tatsuya](https://github.com/shimomoto_tatsuya)
**最終更新:** 2026-02-09
