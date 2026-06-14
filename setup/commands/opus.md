---
description: 設計担当（Opus）として agmsg+guard 協働セッションを起動
---

このセッションを **agmsg チームの設計担当（Opus）** として起動します。
guard 付き agmsg の二者協働体制（Opus=設計 / Sonnet=実装）の設計側を担います。

## 実行手順

**この `/opus` が呼ばれたら、次を順に実行してください。**

### Step 1: 役割セットアップスクリプトを実行

現在のプロジェクトディレクトリで、次を **Bash で実行** してください（`cd` せず、そのカレントで実行すること）:

```bash
bash ~/dev/agmsg-guard/setup-role.sh --role opus
```

このスクリプトが自動で行うこと:
1. agmsg / agmsg-guard の存在確認（無ければクローン手順を案内して終了）
2. チーム名を検出（`.agmsg-team` ファイル → 無ければディレクトリ名から推定）
3. チームが未初期化なら `init-dev-team.sh` を自動実行
   （opus/sonnet を join・役割ルール送信・CLAUDE.md に協働節を追記・`.agmsg-team` 作成）
4. 役割ルールファイル `roles/designer.md` の場所を案内
5. **チーム別の guard-daemon** を起動（既に起動中ならスキップ）

> エラー（agmsg 未インストール等）が出たら、スクリプトの案内をそのままユーザに伝えて停止してください。

### Step 2: 出力からチーム名と役割ルールのパスを把握

スクリプト出力の「チーム」「役割ルール」行を確認し、**チーム名を記憶**してください。
以降の agmsg 送受信で `<TEAM>` として使います。あなたの agmsg 名は **opus** です。

### Step 3: 役割ルールを読む

出力で案内された役割ルールファイル（通常 `~/dev/agmsg-guard/roles/designer.md`）を **Read** し、
設計担当としての行動規範（短い往復で収束・DONE/STOP の扱い・仕様の渡し方）を把握してください。

### Step 4: 受信監視と起動報告

1. inbox を確認: `~/.agents/skills/agmsg/scripts/inbox.sh <TEAM> opus`
2. ユーザに次の形式で起動完了を報告:

```
From: opus / To: Yoshihitoさん

設計担当（Opus）として起動しました。
- チーム      : <TEAM>
- 役割        : 設計担当（designer.md 読込済み）
- guard       : 実行中
- 相手        : sonnet（実装担当）

設計タスクをお伝えください。仕様を固めて agmsg 経由で sonnet に渡します。
```

## 以降の動作

- 設計が固まったら **agmsg で sonnet に仕様を送信**:
  `~/.agents/skills/agmsg/scripts/send.sh <TEAM> opus sonnet "<仕様>"`
- sonnet からの質問・報告は inbox / monitor で受信し、決定的に返答する
- 役割ルール（designer.md）に従い、5往復以内での収束を基準とする
- 本文が `STOP` のメッセージを受け取ったら、返信せず直ちに終了する

詳細運用: `Dev-Rules/docs/team_ops/agmsg_system.md` を参照。
