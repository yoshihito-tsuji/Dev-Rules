
## セッション開始時の必須手順

このプロジェクトで作業を開始する際、**ユーザーの最初のメッセージに応答する前に**以下を実行すること：

1. 自分の役割を確認する（opusまたはsonnet）
2. `bash ~/dev/agmsg-guard/setup-role.sh --role <opus|sonnet>` を実行する
3. 役割が不明な場合はユーザーに「opusですかsonnetですか？」と確認してから実行する

## agmsg チーム協働ルール

このプロジェクトは agmsg+agmsg-guard による三者間共同開発体制で進める。

- **あなたが Claude Code Opus の場合**: ~/dev/agmsg-guard/roles/designer.md を読み、設計担当として動くこと。
- **あなたが Claude Code Sonnet の場合**: ~/dev/agmsg-guard/roles/implementer.md を読み、実装担当として動くこと。
- agmsg チーム名: dev-rules
- コマンド・初期化手順: docs/team_ops/agmsg_system.md を参照。
