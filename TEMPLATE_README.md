# [プロジェクト名]

**[プロジェクトの1行説明]**

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

**開発方法論の詳細**: [Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules) を参照してください。

---

## 📖 目次

1. [プロジェクト概要](#プロジェクト概要)
2. [開発理念](#開発理念)
3. [三者協働開発ルール](#三者協働開発ルール)
4. [現在の状況](#現在の状況)
5. [技術スタック](#技術スタック)
6. [環境構築](#環境構築)
7. [ディレクトリ構成](#ディレクトリ構成)
8. [開発フロー](#開発フロー)

---

## 🎯 プロジェクト概要

### 目的

[このプロジェクトの目的を記載]

### 背景

[なぜこのプロジェクトを始めたのか]

### ゴール

[最終的に達成したいこと]

---

## 💡 開発理念

このプロジェクトは、[Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules)の三者協働開発方法論に基づいて開発されています。

### 基本原則

1. **設計と実装の分離**: 設計（Codex）と実装（Claude Code）を明確に分離
2. **トレーサビリティ**: すべての決定事項と作業履歴を記録
3. **再現性**: 誰でも（AI含む）過去の文脈を理解し、作業を再開できる
4. **継続性**: プロジェクトが中断しても、ドキュメントから再開できる

詳細は [Dev-Rules README](https://github.com/yoshihito-tsuji/Dev-Rules/blob/main/README.md) を参照。

---

## 🤝 三者協働開発ルール

### 三者の役割

| 担当者 | 主な役割 | 責任範囲 |
|--------|---------|---------|
| **Codex** | 設計・アーキテクチャ担当 | 要件分析、システム設計、技術選定、実装計画策定 |
| **Claude Code** | 実装担当 | コーディング、テスト、デバッグ、環境構築 |
| **Yoshihitoさん** | プロダクトオーナー | 最終意思決定、要件定義、方針決定 |

### 重要ルール

1. **すべて日本語で記述**: AI応答、コメント、ドキュメントは必ず日本語で記述すること
2. **設計なしに実装しない**: 新機能や大きな変更は必ずCodexの設計を経由
3. **実装は設計に基づく**: Claude Codeは設計書に基づいて実装
4. **最終決定はYoshihitoさん**: 重要な方針変更は必ずYoshihitoさんの承認を得る
5. **すべてを記録する**: 決定事項、提案、実装内容をドキュメント化

### コミュニケーション形式

すべてのAI応答は以下の形式で開始すること：

```
From: [送信者名]
To: [受信者名]

[メッセージ本文]
```

詳細は [Dev-Rules: コミュニケーションルール](https://github.com/yoshihito-tsuji/Dev-Rules#コミュニケーションルール) を参照。

---

## 📊 現在の状況

### フェーズ

- [ ] 要件定義
- [ ] 基本設計
- [ ] 詳細設計
- [ ] 実装
- [ ] テスト
- [ ] デプロイ

### 最新の状況

[現在の開発状況を記載]

### 次のステップ

[次に予定している作業]

---

## 🛠 技術スタック

### 言語・フレームワーク

- [使用している言語/フレームワーク]

### ライブラリ・ツール

- [使用しているライブラリ]

### ハードウェア（該当する場合）

- [使用しているハードウェア]

---

## 🚀 環境構築

### 前提条件

- [必要な環境やツール]

### セットアップ手順

1. リポジトリをクローン
   ```bash
   git clone https://github.com/yoshihito-tsuji/[project-name].git
   cd [project-name]
   ```

2. [プロジェクト固有のセットアップ手順]

3. [実行方法]

詳細は [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md) を参照。

---

## 📁 ディレクトリ構成

```
project/
├── README.md                     # このファイル
├── DECISIONS.md                  # 重要な決定事項
├── CODEX_START.md                # Codex起動プロンプト
├── docs/
│   ├── team_ops/
│   │   ├── codex_role.md         # Codex役割定義
│   │   ├── claude_code_role.md   # Claude Code役割定義
│   │   └── LOG_TEMPLATE.md       # ログテンプレート
│   ├── design/                   # 設計書
│   └── SETUP_GUIDE.md            # 環境構築詳細
├── LOG/                          # 日次作業ログ
│   └── YYYY-MM-DD.md
└── [プロジェクト固有のディレクトリ]
```

---

## 🔄 開発フロー

### 新機能開発

1. **Yoshihitoさん**: 要件をCodexに伝える
2. **Codex**: 設計書を作成し、Claude Codeに実装指示
3. **Claude Code**: 実装・テスト・ログ記録
4. **Yoshihitoさん**: 実装結果を確認・承認

### バグ修正

1. **Yoshihitoさん**: バグ内容をClaude Codeに伝える
2. **Claude Code**: 軽微なバグは直接修正、設計変更が必要ならCodexに相談
3. **Yoshihitoさん**: 修正結果を確認

詳細は [Dev-Rules: ワークフロー](https://github.com/yoshihito-tsuji/Dev-Rules#ワークフロー) を参照。

---

## 📚 関連ドキュメント

- [Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules) - 三者協働開発方法論
- [docs/team_ops/codex_role.md](docs/team_ops/codex_role.md) - Codex役割定義
- [docs/team_ops/claude_code_role.md](docs/team_ops/claude_code_role.md) - Claude Code役割定義
- [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md) - 環境構築詳細
- [DECISIONS.md](DECISIONS.md) - 重要な決定事項
- [LOG/](LOG/) - 日次作業ログ

---

## 📝 ログと記録

### 日次ログ

`LOG/YYYY-MM-DD.md` に作業内容を記録

### 決定事項

重要な決定は `DECISIONS.md` に1行形式で記録

### 設計書

Codexの設計書は `docs/design/` に格納

---

**最終更新**: YYYY-MM-DD
