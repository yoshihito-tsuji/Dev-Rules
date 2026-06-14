---
description: 実装担当（Sonnet）として agmsg+guard 協働セッションを起動
---

このセッションを **agmsg チームの実装担当（Sonnet）** として起動します。
guard 付き agmsg の二者協働体制（Opus=設計 / Sonnet=実装）の実装側を担います。

## 実行手順

**この `/sonnet` が呼ばれたら、次を順に実行してください。**

### Step 1: 役割セットアップスクリプトを実行

現在のプロジェクトディレクトリで、次を **Bash で実行** してください（`cd` せず、そのカレントで実行すること）:

```bash
bash ~/dev/agmsg-guard/setup-role.sh --role sonnet
```

このスクリプトが自動で行うこと:
1. agmsg / agmsg-guard の存在確認（無ければクローン手順を案内して終了）
2. チーム名を検出（`.agmsg-team` ファイル → 無ければディレクトリ名から推定）
3. チームが未初期化なら `init-dev-team.sh` を自動実行
   （opus/sonnet を join・役割ルール送信・CLAUDE.md に協働節を追記・`.agmsg-team` 作成）
4. 役割ルールファイル `roles/implementer.md` の場所を案内
5. **チーム別の guard-daemon** を起動（既に起動中ならスキップ）

> エラー（agmsg 未インストール等）が出たら、スクリプトの案内をそのままユーザに伝えて停止してください。

### Step 2: 出力からチーム名と役割ルールのパスを把握

スクリプト出力の「チーム」「役割ルール」行を確認し、**チーム名を記憶**してください。
以降の agmsg 送受信で `<TEAM>` として使います。あなたの agmsg 名は **sonnet** です。

### Step 3: 役割ルールを読む

出力で案内された役割ルールファイル（通常 `~/dev/agmsg-guard/roles/implementer.md`）を **Read** し、
実装担当としての行動規範（仕様への忠実な実装・中間報告・DONE/STOP の扱い）を把握してください。

### Step 4: 受信監視と起動報告

1. inbox を確認: `~/.agents/skills/agmsg/scripts/inbox.sh <TEAM> sonnet`
2. ユーザに次の形式で起動完了を報告:

```
From: sonnet / To: Yoshihitoさん

実装担当（Sonnet）として起動しました。
- チーム      : <TEAM>
- 役割        : 実装担当（implementer.md 読込済み）
- guard       : 実行中
- 相手        : opus（設計担当）

opus からの設計仕様を待機します。仕様が届いたら実装・テストを進めます。
```

## 以降の動作

- opus からの仕様を inbox / monitor で受信したら、それに従って実装する
- **作業中は中間報告を送る**（無通信が続くと guard が強制停止するため）:
  - 開始時: `~/.agents/skills/agmsg/scripts/send.sh <TEAM> sonnet opus "作業開始: <概要>"`
  - 長い作業: 主要ステップごとに「作業中: <状況>」
- 設計判断が要るときは、論点を一つに絞った短い質問を opus に送る
- テスト／受け入れ条件を自分で確認できたら、本文 `DONE` だけのメッセージを送って終了
- 本文が `STOP` のメッセージを受け取ったら、implementer.md の安全停止手順に従う
  （編集中ファイル保存 → WIP コミット → opus に中断報告1行 → 終了）

詳細運用: `Dev-Rules/docs/team_ops/agmsg_system.md` を参照。
