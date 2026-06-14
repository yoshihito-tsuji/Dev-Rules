# CLAUDE.md — [プロジェクト名]

> このファイルはClaude Code起動時の自動オリエンテーション用です。
> 詳細な正本はREADME.mdを参照してください。
> **目標: 60〜100行。最大150行以下。**

---

## プロジェクト要約

[1〜2行でプロジェクトの目的を記述]

---

## 現在フェーズ

[例: v1.x 安定運用中 / v2 開発準備中 / 初期開発中]

## 直近の優先事項

1. [最優先タスク]
2. [次の優先タスク]
3. [その次のタスク]

---

## 技術スタック

- **言語**: [Python / TypeScript / Swift 等]
- **主要ライブラリ**: [フレームワーク名]
- **対応プラットフォーム**: [macOS / Windows / Web / iOS]

## 主要ディレクトリ・ファイル

```
project/
├── [主要ディレクトリ1]/  # [役割]
├── [主要ディレクトリ2]/  # [役割]
├── docs/team_ops/        # 役割定義ファイル
├── LOG/                  # 日次ログ（追記専用）
├── DECISIONS.md          # 重要な決定事項
└── README.md             # 正本（詳細はここ）
```

## 実行・テストコマンド

```bash
# 開発サーバー起動 / メイン実行
[コマンド]

# テスト実行
[コマンド]
```

---

## プロジェクト固有ルール

- [Dev-Rulesとの差分のみ記載]
- [なければ「なし（Dev-Rulesに準拠）」と書く]

---

## 起動時に最初に読むべきファイル

1. `DECISIONS.md` — 重要な決定事項
2. `LOG/YYYY-MM-DD.md` — 直近の作業状況（今日の日付のファイル）
3. あなたの役割定義ファイル（どちらか一方）:
   - Opus（設計担当）の場合: `~/dev/agmsg-guard/roles/designer.md`
   - Sonnet（実装担当）の場合: `~/dev/agmsg-guard/roles/implementer.md`

## 参照先

- プロジェクト詳細: `README.md`
- 協働ルール: `../Dev-Rules/README.md`
- 設計書: `docs/design/` または `docs/development/`
- 作業ログ: `LOG/`
- agmsg システム: `docs/team_ops/agmsg_system.md`
- エスカレーション手順: `docs/team_ops/escalation_guide.md`

---

## agmsg チーム協働ルール

このプロジェクトは agmsg+agmsg-guard による三者間共同開発体制で進める。

- **あなたが Claude Code Opus の場合**: `~/dev/agmsg-guard/roles/designer.md` を読み、設計担当として動くこと。
- **あなたが Claude Code Sonnet の場合**: `~/dev/agmsg-guard/roles/implementer.md` を読み、実装担当として動くこと。
- agmsg チーム名: [TEAM]（プロジェクト開始時に init-dev-team.sh で設定済み）
- コマンド・初期化手順: `docs/team_ops/agmsg_system.md` を参照。

---

<!-- 運用メモ（このコメントはファイルに残してよい）
- README.md が正本。CLAUDE.md はその要約キャッシュ。
- 技術スタックや制約が変わったときのみ CLAUDE.md を更新する。
- 日々の進捗は LOG/ と DECISIONS.md に記録し、CLAUDE.md には書かない。
- Dev-Rulesテンプレート: ~/Claude_Code/Dev-Rules/TEMPLATE_CLAUDE.md
-->
