# [プロジェクト名]

**[プロジェクトの1行説明]**

---

## 🚨 重要：AI担当者への最優先指示

**このREADME.mdを最初から最後まで必ず精読してください。**

### 🤖 AI起動時の自動読み込み指示

このプロジェクトは **agmsg + agmsg-guard による二者協働開発体制**（Claude Code Opus = 設計担当 / Claude Code Sonnet = 実装担当）で進めます。
新しい Claude Code ウィンドウを開いたら、スラッシュコマンドで役割を設定してください。

#### Claude Code Opus（設計担当）の場合

- このウィンドウで **`/opus`** を実行してください
- → チーム参加・役割ルール読込・guard 起動まで自動で行われます（実体: `~/dev/agmsg-guard/setup-role.sh`）

#### Claude Code Sonnet（実装担当）の場合

- このウィンドウで **`/sonnet`** を実行してください
- → チーム参加・役割ルール読込まで自動で行われます

#### xangi システム / LOCO（相談役・整理役）の場合

1. 次に `docs/team_ops/xangi_system_role.md` を読んでください
2. その後、そのファイルに記載された起動手順に従ってください

**重要**: `/opus`・`/sonnet` 実行後は、案内された役割ルール（`roles/designer.md` / `roles/implementer.md`）を読み、
さらに DECISIONS.md・LOG の確認等の起動手順を必ず実行してください。詳細は [docs/team_ops/agmsg_system.md](docs/team_ops/agmsg_system.md) を参照。

---

### 📋 AI起動時の必須手順（概要）

1. **README.md精読** → プロジェクト全体像を把握
2. **役割定義確認** → `docs/team_ops/claude_code_design_role.md` または `claude_code_role.md` を確認
3. **LOG確認** → `LOG/YYYY-MM-DD.md` で当日の作業状況を確認
4. **DECISIONS確認** → `DECISIONS.md` で重要な決定事項を確認
5. **KNOWN_ISSUES確認** → `KNOWN_ISSUES.md` で既知の問題と解決策を確認
6. **From/To形式で応答開始** → 必ず「From: [あなたの名前] / To: [受信者名]」形式で開始

### ⚠️ 禁止事項

- README.mdを読まずに作業を開始すること
- 協働ルールを無視して単独で判断すること
- From/To形式を使わずに応答すること
- ログや決定事項を記録せずに作業を進めること
- **日本語以外の言語（英語等）で応答・ドキュメント・コメントを記述すること**

**開発方法論の詳細**: [Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules) を参照してください。

---

## 📖 目次

1. [プロジェクト概要](#プロジェクト概要)
2. [開発理念](#開発理念)
3. [協働開発ルール](#協働開発ルール)
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

このプロジェクトは、[Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules)の四者協働開発方法論に基づいて開発されています。

### 基本原則

1. **設計と実装の分離**: 設計（Claude Code Opus）と実装（Claude Code Sonnet）を明確に分離
2. **トレーサビリティ**: すべての決定事項と作業履歴を記録
3. **再現性**: 誰でも（AI含む）過去の文脈を理解し、作業を再開できる
4. **継続性**: プロジェクトが中断しても、ドキュメントから再開できる
5. **安全な協働**: agmsg でメッセージをやり取りし、agmsg-guard が無限ループを防止する
6. **対話の整理**: xangi システム / LOCO が、説明のかみ砕きと追加確認を支援する

詳細は [Dev-Rules README](https://github.com/yoshihito-tsuji/Dev-Rules/blob/main/README.md) を参照。

---

## 🤝 協働開発ルール

二者協働（Opus = 設計 / Sonnet = 実装）を基本とし、必要時に補助メンバーが参加します。

### 役割

| 担当者 | 主な役割 | 責任範囲 |
|--------|---------|---------|
| **Claude Code Opus（設計担当）** | 設計・アーキテクチャ担当 | 要件分析、システム設計、技術選定、仕様を agmsg で Sonnet に渡す |
| **Claude Code Sonnet（実装担当）** | 実装担当 | コーディング、テスト、デバッグ、中間報告・DONE 送信 |
| **Yoshihitoさん** | プロダクトオーナー | 最終意思決定、要件定義、方針決定 |
| **Codex**（必要時） | 難問の相談役 | 二者で解決困難な設計上の難問を Opus が相談 |
| **xangi システム / LOCO**（必要時） | 相談役・整理役 | 要件のかみ砕き、状況整理、追加確認、説明補助 |

### 重要ルール

1. **すべて日本語で記述**: AI応答、コメント、ドキュメントは必ず日本語で記述すること
2. **設計なしに実装しない**: 新機能や大きな変更は必ず Opus の設計を経由
3. **実装は設計に基づく**: Sonnet は Opus の仕様に基づいて実装
4. **agmsg で協働**: Opus⇔Sonnet のやり取りは agmsg 経由。標準10往復以内で収束（guard 上限20往復）
5. **最終決定はYoshihitoさん**: 重要な方針変更は必ずYoshihitoさんの承認を得る
6. **すべてを記録する**: 決定事項、提案、実装内容をドキュメント化

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
├── KNOWN_ISSUES.md               # 既知の問題と解決策
├── docs/
│   ├── team_ops/
│   │   ├── xangi_system_role.md     # xangi システム / LOCO の役割定義
│   │   ├── claude_code_design_role.md  # Claude Code設計役割定義
│   │   ├── claude_code_role.md         # Claude Code実装役割定義
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

1. **Yoshihitoさん**: 要件を Opus（設計担当）に伝える
2. **Opus（設計）**: 要件を分析・仕様を策定し、agmsg 経由で Sonnet に送信（10往復以内で収束）
3. **Sonnet（実装）**: 仕様に従って実装・テスト・ログ記録・Git commit、完了後 agmsg で `DONE` 送信
4. **agmsg-guard**: 対話を監視し、上限超過・タイムアウトで自動停止
5. **Yoshihitoさん**: 実装結果を確認・承認

### バグ修正

1. **Yoshihitoさん**: バグ内容を Opus または Sonnet に伝える
2. **Opus（設計）**: 軽微なら Sonnet に直接修正指示（agmsg 経由）、設計変更が要るなら方針を設計
3. **Sonnet（実装）**: 修正実装・テスト・ログ記録・`DONE` 送信
4. **Yoshihitoさん**: 修正結果を確認

詳細は [Dev-Rules: ワークフロー](https://github.com/yoshihito-tsuji/Dev-Rules#ワークフロー) を参照。

---

## 📚 関連ドキュメント

- [Dev-Rules](https://github.com/yoshihito-tsuji/Dev-Rules) - 協働開発方法論
- [docs/team_ops/agmsg_system.md](docs/team_ops/agmsg_system.md) - agmsg + agmsg-guard システム概要・起動手順
- [docs/team_ops/xangi_system_role.md](docs/team_ops/xangi_system_role.md) - xangi システム / LOCO 役割定義
- [docs/team_ops/claude_code_design_role.md](docs/team_ops/claude_code_design_role.md) - Claude Code設計役割定義
- [docs/team_ops/claude_code_role.md](docs/team_ops/claude_code_role.md) - Claude Code実装役割定義
- [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md) - 環境構築詳細
- [DECISIONS.md](DECISIONS.md) - 重要な決定事項
- [KNOWN_ISSUES.md](KNOWN_ISSUES.md) - 既知の問題と解決策
- [LOG/](LOG/) - 日次作業ログ

---

## 📝 ログと記録

### 日次ログ

`LOG/YYYY-MM-DD.md` に作業内容を記録

### 決定事項

重要な決定は `DECISIONS.md` に1行形式で記録

### 既知の問題と解決策

過去に発生した問題と解決策は `KNOWN_ISSUES.md` に記録。AI担当者が同じ問題を繰り返さないための「組織の記憶」として機能する。原因の特定に時間がかかった問題を優先的に記録すること。重大度（Critical / Warning / Info）とステータス（未解決 / 解決済み）で分類する。

### 設計書

設計担当Claude Codeの設計書は `docs/design/` に格納

---

**最終更新**: YYYY-MM-DD（テンプレート改訂: 2026-06-14 agmsg+guard 二者協働体制対応）
