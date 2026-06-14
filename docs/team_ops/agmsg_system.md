# agmsg+agmsg-guard システム概要

agmsg は SQLite ベースのエージェント間メッセージングシステムです。Claude Code Opus（設計担当）と Claude Code Sonnet（実装担当）が agmsg チームを通じてメッセージをやり取りし、agmsg-guard がそのダイアログを監視して無限ループを防止します。ネットワーク不要・デーモン不要で、bash と sqlite3 のみで動作します。

## 初期化コマンド

```bash
bash ~/dev/agmsg-guard/init-dev-team.sh --team <TEAM> --project <PATH>
```

ロールルールの場所: `~/dev/agmsg-guard/roles/`

- `designer.md` — 設計担当（Opus）向けルール
- `implementer.md` — 実装担当（Sonnet）向けルール

## guard 停止条件（最初にヒットしたもの優先）

| 条件 | 説明 |
|------|------|
| メッセージ上限 | 起動時点からのメッセージ数が上限（デフォルト: 20往復=40件）を超えた |
| DONE | 誰かが本文 `DONE` のみのメッセージを送信した |
| ウォールタイムアウト | `--wall-timeout` で指定した秒数が経過した |
| アイドルタイムアウト | `--idle-timeout` で指定した秒数、新着メッセージがなかった |

## 基本コマンド（agmsg スクリプト）

```bash
# メッセージ送信
bash ~/.agents/skills/agmsg/scripts/send.sh <TEAM> <FROM> <TO> '<メッセージ>'

# 受信監視（monitor モード）
bash ~/.agents/skills/agmsg/scripts/watch.sh <SESSION_ID> <PROJECT_DIR> claude-code

# 受信トレイ確認
bash ~/.agents/skills/agmsg/scripts/inbox.sh <TEAM> <AGENT>

# チームメンバー一覧
bash ~/.agents/skills/agmsg/scripts/team.sh <TEAM>

# メッセージ履歴
bash ~/.agents/skills/agmsg/scripts/history.sh <TEAM> <AGENT>
```

## 参照ドキュメント

- `~/dev/agmsg-guard/README.md` — guard.sh の全オプションと使用例
- `docs/team_ops/claude_code_design_role.md` — 設計担当（Opus）の役割定義
- `docs/team_ops/claude_code_role.md` — 実装担当（Sonnet）の役割定義

---

**最終更新**: 2026-06-14
