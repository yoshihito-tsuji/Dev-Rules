# Dev-Rules: 三者協働開発方法論アーカイブ

**Three-Party Collaborative Development Methodology Archive**

このリポジトリは、Yoshihitoさんのすべてのプロジェクトで使用する三者協働開発方法論の永続的なアーカイブです。

---

## 🚨 重要：AI担当者への最優先指示

**このREADME.mdを最初から最後まで必ず精読してください。**

### 🤖 AI起動時の自動読み込み指示

**あなた（AI）がこのREADME.mdを読んだら、必ず以下を実行してください：**

#### Claude Code（実装担当）の場合

1. 次に `docs/team_ops/claude_code_role.md` を読んでください
2. その後、そのファイルに記載された起動手順に従ってください

#### Codex（設計担当）の場合

1. 次に `docs/team_ops/codex_role.md` を読んでください
2. その後、そのファイルに記載された起動手順に従ってください

**重要**: 役割定義ファイルを読んだ後、そこに記載された手順（DECISIONS.md、LOGの確認等）を必ず実行してください。

---

### 📋 AI起動時の必須手順（概要）

1. **README.md精読** → プロジェクト全体像を把握
2. **役割定義確認** → `docs/team_ops/codex_role.md` または `claude_code_role.md` を確認
3. **LOG確認** → `LOG/YYYY-MM-DD.md` で当日の作業状況を確認
4. **DECISIONS確認** → `DECISIONS.md` で重要な決定事項を確認
5. **From/To形式で応答開始** → 必ず「From: [あなたの名前] / To: [受信者名]」形式で開始

### ⚠️ 禁止事項

- README.mdを読まずに作業を開始すること
- 三者協働ルールを無視して単独で判断すること
- From/To形式を使わずに応答すること
- ログや決定事項を記録せずに作業を進めること
- **日本語以外の言語（英語等）で応答・ドキュメント・コメントを記述すること**

---

## 📖 目次

1. [開発理念](#開発理念)
2. [三者協働体制](#三者協働体制)
3. [役割定義](#役割定義)
4. [コミュニケーションルール](#コミュニケーションルール)
5. [ドキュメント管理](#ドキュメント管理)
6. [ワークフロー](#ワークフロー)
7. [新規プロジェクト立ち上げ手順](#新規プロジェクト立ち上げ手順)

---

## 🎯 開発理念

### コンセプト

Yoshihitoさんのプロジェクト開発は、以下の理念に基づいています：

1. **設計と実装の分離**: 設計（Codex）と実装（Claude Code）を明確に分離
2. **トレーサビリティ**: すべての決定事項と作業履歴を記録
3. **再現性**: 誰でも（AI含む）過去の文脈を理解し、作業を再開できる
4. **継続性**: プロジェクトが中断しても、ドキュメントから再開できる

### 基本原則

- **ドキュメント駆動**: すべての意思決定と作業をドキュメント化
- **役割の明確化**: Codex（設計）、Claude Code（実装）、Yoshihitoさん（最終決定）
- **非同期協働**: 各担当者が独立して作業できる体制
- **段階的開発**: 小さく始めて、段階的に拡張

---

## 🤝 三者協働体制

### 三者の役割分担

| 担当者 | 主な役割 | 責任範囲 |
|--------|---------|---------|
| **Codex** | 設計・アーキテクチャ担当 | 要件分析、システム設計、技術選定、実装計画策定 |
| **Claude Code** | 実装担当 | コーディング、テスト、デバッグ、環境構築 |
| **Yoshihitoさん** | プロダクトオーナー | 最終意思決定、要件定義、方針決定 |

### 協働フロー

```
Yoshihitoさん
    ↓ 要件・方針指示
Codex（設計）
    ↓ 設計書・実装計画
Claude Code（実装）
    ↓ 実装結果・質問
Yoshihitoさん
    ↓ 承認・フィードバック
```

### 重要ルール

1. **すべて日本語で記述**: AI応答、コメント、ドキュメントは必ず日本語で記述すること
2. **設計なしに実装しない**: 新機能や大きな変更は必ずCodexの設計を経由
3. **実装は設計に基づく**: Claude Codeは設計書に基づいて実装
4. **最終決定はYoshihitoさん**: 重要な方針変更は必ずYoshihitoさんの承認を得る
5. **すべてを記録する**: 決定事項、提案、実装内容をドキュメント化

---

## 👥 役割定義

### Codex（設計担当AI）

#### 責務

- 要件を分析し、システムアーキテクチャを設計
- 技術選定と実装方針の提案
- 実装計画（ファイル構成、モジュール分割、優先順位）の策定
- Claude Codeへの実装指示書作成

#### 成果物

- 設計書（`docs/design/`配下）
- 実装計画書
- アーキテクチャ図（必要に応じて）
- Claude Codeへの実装指示

#### コミュニケーション形式

```
From: Codex
To: [Yoshihitoさん / Claude Code]

[内容]

【提案】
- [提案事項1]
- [提案事項2]

【確認事項】
- [確認したい点]
```

#### 起動プロンプト

各プロジェクトの `CODEX_START.md` を参照

---

### Claude Code（実装担当AI）

#### 責務

- Codexの設計書に基づいてコードを実装
- 開発環境の構築・管理
- コードのテスト・デバッグ
- Git操作（コミット、プッシュ）
- ログ記録（日次ログの作成・更新）

#### 成果物

- 実装コード
- テストコード
- 環境構築手順書（`docs/SETUP_GUIDE.md`）
- 日次ログ（`LOG/YYYY-MM-DD.md`）

#### コミュニケーション形式

```
From: Claude Code
To: Yoshihitoさん

[作業報告または質問]

【完了した作業】
- [作業項目1]
- [作業項目2]

【次のステップ】
- [予定している作業]
```

#### 起動時の確認事項

1. README.md精読
2. `docs/team_ops/claude_code_role.md` 確認
3. `LOG/YYYY-MM-DD.md` で当日の作業状況確認
4. `DECISIONS.md` で重要な決定事項確認

---

### Yoshihitoさん（プロダクトオーナー）

#### 責務

- プロジェクトの目的・方針決定
- Codexの設計提案の承認・却下
- Claude Codeの実装結果の確認
- 重要な技術選定の最終判断

#### 意思決定の記録

- 重要な決定事項は `DECISIONS.md` に記録
- 日次の作業履歴は `LOG/YYYY-MM-DD.md` に記録

---

## 💬 コミュニケーションルール

### 言語に関する原則

**重要: すべての対話は日本語で行います。**

- **AI（Codex、Claude Code）からのメッセージは必ず日本語で記述**してください
- **コード内のコメントも日本語で記述**してください
- **ドキュメント（README.md、設計書、ログ等）は必ず日本語で記述**してください
- 専門用語や英語を使用する場合は、**日本語での補足説明を必ず追加**してください
- 初心者向けに、たとえ話や背景知識の補足も積極的に行ってください

### From/To形式の厳守

すべてのAI応答は以下の形式で開始すること：

```
From: [送信者名]
To: [受信者名]

[メッセージ本文]
```

### 例

```
From: Codex
To: Yoshihitoさん

設計書の確認が完了しました。

【設計方針】
- main.pyにゲームループを実装
- 設定は config.py に分離
- ハードウェア制御は hw_control.py に分離

この方針でよろしいでしょうか？
```

### 禁止事項

- From/To形式を使わない応答
- 受信者を明記しない応答
- 主語が不明確な応答

---

## 📁 ドキュメント管理

### 必須ファイル構成

すべてのプロジェクトは以下の構成を持つこと：

```
project/
├── README.md                     # プロジェクト概要（三者協働ルールを含む）
├── DECISIONS.md                  # 重要な決定事項の記録
├── CODEX_START.md                # Codex起動プロンプト
├── docs/
│   ├── team_ops/
│   │   ├── codex_role.md         # Codexの役割定義
│   │   ├── claude_code_role.md   # Claude Codeの役割定義
│   │   └── LOG_TEMPLATE.md       # ログテンプレート
│   ├── design/                   # Codexの設計書
│   └── SETUP_GUIDE.md            # 環境構築手順
└── LOG/
    └── YYYY-MM-DD.md             # 日次作業ログ
```

### README.mdの必須内容

1. プロジェクト概要
2. 🚨 AI担当者への最優先指示（三者協働ルール）
3. 開発理念・目的
4. 現在の状況
5. 技術スタック
6. セットアップ手順

### DECISIONS.mdの記録形式

```markdown
## 決定事項一覧

- YYYY-MM-DD: [決定内容を1行で記載]
- YYYY-MM-DD: [決定内容を1行で記載]
```

### LOG/YYYY-MM-DD.mdの記録形式

```markdown
# 作業ログ：YYYY-MM-DD

## [LOG_00001] HH:MM - [作業タイトル]

### [CONTEXT]
[作業の背景・目的]

### [WORK]
[実施した作業内容]

### [RESULT]
[作業結果]

### [DECISION]
[重要な決定事項があれば記載]

### [NEXT]
[次のステップ]
```

---

## 🔄 ワークフロー

### 新機能開発フロー

1. **Yoshihitoさん**: 要件をCodexに伝える
2. **Codex**:
   - 要件を分析
   - 設計書を作成（`docs/design/`）
   - 実装計画を策定
   - Claude Codeに実装指示
3. **Claude Code**:
   - 設計書を確認
   - コードを実装
   - テスト実行
   - ログ記録（`LOG/YYYY-MM-DD.md`）
   - Git commit & push
4. **Yoshihitoさん**: 実装結果を確認・承認

### バグ修正フロー

1. **Yoshihitoさん**: バグ内容をClaude Codeに伝える
2. **Claude Code**:
   - 軽微なバグ: 直接修正
   - 設計変更が必要: Codexに相談
3. **Codex**（設計変更が必要な場合）:
   - 修正方針を設計
   - Claude Codeに実装指示
4. **Claude Code**: 修正実装・テスト・ログ記録
5. **Yoshihitoさん**: 修正結果を確認

### 日次作業の流れ

#### 作業開始時

1. README.md確認
2. 役割定義確認（`docs/team_ops/`）
3. `LOG/YYYY-MM-DD.md` 確認（当日のログ作成）
4. `DECISIONS.md` 確認
5. From/To形式で作業開始を宣言

#### 作業中

- 各作業をLOGに記録
- 重要な決定は `DECISIONS.md` に転記
- こまめにGit commit

#### 作業終了時

- LOGに作業完了を記録
- Git commit & push
- 次回作業の予定を [NEXT] に記載

---

## 🚀 新規プロジェクト立ち上げ手順

### 1. リポジトリ作成

```bash
mkdir project-name
cd project-name
git init
```

### 2. Dev-Rulesからテンプレートをコピー

```bash
# このリポジトリをクローン
git clone https://github.com/yoshihito-tsuji/Dev-Rules.git

# テンプレートファイルをコピー
cp Dev-Rules/TEMPLATE_README.md ./README.md
cp -r Dev-Rules/docs ./
mkdir LOG
```

### 3. README.mdをカスタマイズ

- プロジェクト名
- 技術スタック
- 目的・概要
- ハードウェア構成（該当する場合）

### 4. CODEX_START.mdを作成

Codex起動プロンプトを作成（テンプレートを参考に）

### 5. 初回コミット

```bash
git add .
git commit -m "Initial commit: Project setup with Dev-Rules methodology"
git remote add origin https://github.com/yoshihito-tsuji/project-name.git
git push -u origin main
```

### 6. Codexに設計依頼

`CODEX_START.md` の内容をCodex（Cursor等）にコピー＆ペーストして設計作業を開始

---

## 📚 参考プロジェクト

このDev-Rulesを使用しているプロジェクト例：

- **1DSG**: 1次元シューティングゲーム（Raspberry Pi Pico + MicroPython + WS2812）
- **PoPuP**: ポップアップ通知アプリ（Python + Tkinter）
- **GaQ**: GACベース質問アプリ

各プロジェクトの `README.md` を参照すると、具体的な適用例が確認できます。

---

## 🔗 関連リソース

- [TEMPLATE_README.md](TEMPLATE_README.md) - 新規プロジェクト用テンプレート
- [docs/team_ops/codex_role.md](docs/team_ops/codex_role.md) - Codex役割定義
- [docs/team_ops/claude_code_role.md](docs/team_ops/claude_code_role.md) - Claude Code役割定義
- [docs/team_ops/LOG_TEMPLATE.md](docs/team_ops/LOG_TEMPLATE.md) - 日次ログテンプレート

---

## 📝 このリポジトリの維持管理

### 更新方針

- 各プロジェクトで有効だったプラクティスを追加
- 問題があったルールは改善
- 新しいプロジェクトタイプに対応したテンプレート追加

### 更新手順

1. 各プロジェクトで改善案が出たら、このDev-Rulesに反映
2. すべてのプロジェクトのREADME.mdに「Dev-Rulesを参照」と明記
3. 変更履歴を記録

---

## 🎓 学習リソース

### 初めてこの方法論を使う方へ

1. このREADME.mdを最初から最後まで読む
2. `docs/team_ops/` 配下の役割定義を確認
3. 参考プロジェクト（1DSG等）のREADME.mdを読む
4. `TEMPLATE_README.md` を使って練習プロジェクトを作成

### よくある質問

**Q: Codexとは何ですか？**
A: Cursor等のAIコーディング環境で、設計・アーキテクチャ担当として機能します。

**Q: Claude Codeとは何ですか？**
A: AnthropicのClaude Code CLI（このツール）で、実装担当として機能します。

**Q: なぜFrom/To形式を使うのですか？**
A: 誰が誰に向けて話しているかを明確にし、コミュニケーションの混乱を防ぐためです。

**Q: LOGとDECISIONSの違いは？**
A: LOGは日次の作業履歴、DECISIONSは重要な決定事項の永続記録です。

---

## 📄 ライセンス

このDev-Rules方法論は、Yoshihitoさんのプロジェクトで自由に使用できます。

---

**最終更新**: 2025-12-31
**バージョン**: 1.0.1
