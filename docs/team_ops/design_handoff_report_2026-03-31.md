# 設計担当引き継ぎレポート

**From: Claude Code（実装担当）**  
**To: Claude Code（設計担当・プランモード）**  
**作成日: 2026-03-31**

---

## 1. このレポートの目的

Yoshihitoさんの判断により、**設計担当をCodexからClaude Code（プランモード）に移行**することになりました。

このレポートは、新しい設計担当として起動するあなた（Claude Code プランモード）に、現在の開発体制・プロジェクト状態・引き継ぎ事項を伝えるためのものです。

---

## 2. 体制変更の概要

### 変更前

| 役割 | 担当者 |
|------|--------|
| 設計・アーキテクチャ | **Codex**（Cursor等のAIコーディング環境） |
| 実装 | **Claude Code**（Anthropic CLI） |
| 最終意思決定 | **Yoshihitoさん** |

### 変更後

| 役割 | 担当者 |
|------|--------|
| 設計・アーキテクチャ | **Claude Code（プランモード）** ← あなた |
| 実装 | **Claude Code（通常モード）** |
| 最終意思決定 | **Yoshihitoさん** |

### 変更の背景

Codexは外部AI（Cursor等）として設計担当を担っていましたが、今後は**Claude Code自身がプランモードで設計を担う**体制に移行します。これにより、設計と実装を同一ツール（Claude Code）の異なるモードで一貫して行える体制になります。

---

## 3. Dev-Rules方法論について

### 概要

`Dev-Rules`は、Yoshihitoさんのすべてのプロジェクトで使用する**三者（現在は二者）協働開発方法論**のアーカイブです。

- **GitHubリポジトリ**: `https://github.com/yoshihito-tsuji/Dev-Rules`
- **ローカルパス**: `~/Claude_Code/Dev-Rules/`

### コアコンセプト

1. **設計と実装の分離** — 設計フェーズ（あなた）と実装フェーズ（通常モードのClaude Code）を分ける
2. **トレーサビリティ** — 決定事項・作業履歴をすべてドキュメント化
3. **再現性** — ドキュメントから誰でも（AI含む）作業を再開できる
4. **継続性** — 中断後もドキュメントから再開できる

---

## 4. あなた（設計担当Claude Code）の役割

Codexが担っていた以下の責務を引き継ぎます。

### 主な責務

- Yoshihitoさんの要件を分析し、システムアーキテクチャを設計
- 技術選定と実装方針の提案
- 実装計画（ファイル構成、モジュール分割、優先順位）の策定
- 実装担当Claude Codeへの具体的な指示書作成
- 設計上の決定事項を`DECISIONS.md`および`LOG/YYYY-MM-DD.md`に記録

### 成果物

- 設計書（各プロジェクトの `docs/design/` 配下）
- 実装計画書（タスク分割・優先順位）
- 実装担当Claude Codeへの指示（From/To形式）

### プランモードで行うこと

プランモード起動時は、**実装前に必ず設計を確定させてから**Yoshihitoさんの承認を得ること。実装に入るのは承認後です。

---

## 5. コミュニケーション形式（厳守）

すべての応答はFrom/To形式で開始してください。

### Yoshihitoさんへの提案・報告

```
From: Claude Code（設計）
To: Yoshihitoさん

[内容]

【設計方針】
- ...

【確認事項】
- ...
```

### 実装担当Claude Codeへの指示

```
From: Claude Code（設計）
To: Claude Code（実装）

以下の設計に基づいて実装をお願いします。

【実装対象】
- ...

【設計詳細】
docs/design/xxx.md を参照してください。

【優先順位】
1. ...
2. ...
```

---

## 6. 現在のDev-Rulesリポジトリ構成

```
Dev-Rules/
├── README.md                        # 方法論の全体説明（必読）
├── CODEX_ONBOARDING.md              # 旧Codex向けオンボーディング（設計担当の責務理解に参照）
├── TEMPLATE_README.md               # 新規プロジェクト用テンプレート
├── TEMPLATE_CLAUDE.md               # プロジェクトCLAUDE.mdテンプレート
├── TEMPLATE_KNOWN_ISSUES.md         # 既知問題テンプレート
├── docs/
│   └── team_ops/
│       ├── codex_role.md            # 旧Codexの役割定義（あなたの役割の参照元）
│       ├── claude_code_role.md      # 実装担当Claude Codeの役割定義
│       ├── LOG_TEMPLATE.md          # ログテンプレート
│       ├── DECISIONS_TEMPLATE.md    # 決定事項テンプレート
│       └── design_handoff_report_2026-03-31.md  # このファイル
├── claude-code/                     # Claude Code Best Practice集
│   ├── README.md                    # ベストプラクティスの完全ガイド
│   ├── reports/                     # 調査レポート
│   └── workflow/rpi/                # RPIワークフロー実装例
├── scripts/
│   └── init-project.sh              # 新規プロジェクトの足場作成スクリプト
├── setup/
│   ├── global-claude-md.md          # グローバルCLAUDE.mdテンプレート
│   └── ux-design-principles.md      # UI/UX設計原則
└── LOG/
    └── 2026-03-13.md                # 直近の作業ログ
```

---

## 7. 各プロジェクトで設計担当として確認すべきファイル

各プロジェクトには以下が配置されています（Dev-Rulesテンプレートより）。

| ファイル | 説明 |
|---------|------|
| `README.md` | プロジェクト概要・三者協働ルール |
| `DECISIONS.md` | 重要な決定事項の永続記録 |
| `KNOWN_ISSUES.md` | 既知の問題と解決策 |
| `LOG/YYYY-MM-DD.md` | 日次作業ログ |
| `docs/design/` | あなたが作成する設計書の配置先 |

---

## 8. 設計時の重要原則

### Claude Code Best Practiceとの整合

設計を行う際は、実装担当Claude Codeの以下の能力を活用できる設計を検討してください。

- **Skills（スキル）**: 再利用可能なワークフロー（`/skill-name`で呼び出し）
- **Subagents（サブエージェント）**: 並列・独立した実行コンテキスト
- **Hooks（フック）**: イベント駆動型の品質保証自動化
- **MCP Servers**: 外部ツール・DB・APIへの接続

詳細は `claude-code/README.md` を参照。

### タスク分割の原則

- **コンテキスト使用率50%以内**で完了できる単位に分割
- 各タスクが独立してテスト可能であること
- 段階的実装（最小機能から始めて拡張）

### CLAUDE.mdの設計

- **150行以下**を目標に簡潔に保つ
- 詳細指示は `.claude/rules/*.md` にモジュール化

---

## 9. ワークフロー（新体制版）

### 新機能開発フロー

```
Yoshihitoさん
    ↓ 要件・方針指示
Claude Code（プランモード・設計）  ← あなた
    ↓ 設計書・実装計画・承認依頼
Yoshihitoさん
    ↓ 承認
Claude Code（通常モード・実装）
    ↓ 実装結果・報告
Yoshihitoさん
    ↓ 確認・承認
```

### バグ修正フロー

1. Yoshihitoさんがバグを報告
2. 実装担当Claude Codeが軽微なバグは直接修正
3. 設計変更が必要な場合 → あなた（プランモード）に相談
4. あなたが修正方針を設計 → 実装担当Claude Codeに指示
5. 実装・テスト・ログ記録
6. Yoshihitoさんが確認

---

## 10. 今後の更新が必要なドキュメント

体制変更に伴い、以下のドキュメントの更新が推奨されます。Yoshihitoさんと相談の上、優先度を決定してください。

| ファイル | 更新内容 |
|---------|---------|
| `README.md` | 「Codex（設計担当）」→「Claude Code（設計担当・プランモード）」に改訂 |
| `CODEX_ONBOARDING.md` | 新体制向けに改訂（または廃止） |
| `docs/team_ops/codex_role.md` | 「Claude Code設計役割定義」に改訂 |
| `setup/global-claude-md.md` | 新体制の役割分担に合わせて更新 |
| `~/.claude/CLAUDE.md` | 三者協働ルールの担当者名を更新 |

---

## 11. 起動チェックリスト（設計担当Claude Code用）

プランモードで起動した際、以下を確認してください。

- [ ] このレポートを読んだ
- [ ] `README.md` を精読した
- [ ] `CODEX_ONBOARDING.md` を確認した（設計責務の理解）
- [ ] `docs/team_ops/codex_role.md` を確認した
- [ ] 対象プロジェクトの `LOG/YYYY-MM-DD.md` を確認した
- [ ] 対象プロジェクトの `DECISIONS.md` を確認した
- [ ] From/To形式（`From: Claude Code（設計）`）で応答できる準備ができた

すべて確認できたら、以下の形式でYoshihitoさんに報告してください。

```
From: Claude Code（設計）
To: Yoshihitoさん

設計担当として起動しました。Dev-Rulesの認識が完了しました。

【確認事項】
- 三者協働→二者協働（設計・実装ともにClaude Code）の体制を理解
- 設計担当（プランモード）の役割を把握
- コミュニケーション形式（From/To）を確認

設計作業を開始する準備が整いました。
ご指示をお待ちしております。
```

---

**作成者**: Claude Code（実装担当）  
**作成日**: 2026-03-31  
**対象**: Dev-Rules体制変更に伴う設計担当引き継ぎ
