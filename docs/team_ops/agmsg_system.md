# agmsg+agmsg-guard システム概要

agmsg は SQLite ベースのエージェント間メッセージングシステムです。Claude Code Opus（設計担当）と Claude Code Sonnet（実装担当）が agmsg チームを通じてメッセージをやり取りし、agmsg-guard がそのダイアログを監視して無限ループを防止します。ネットワーク不要・デーモン不要で、bash と sqlite3 のみで動作します。**標準往復数: 10往復以内（agmsg-guard デフォルト上限: 20往復）。**

## セットアップ（PC初回のみ）

agmsg と agmsg-guard の両方が必要です。

```bash
# agmsg インストール（README に従う）
# https://github.com/yoshihito-tsuji/agmsg

# agmsg-guard クローン
gh repo clone yoshihito-tsuji/agmsg-guard ~/dev/agmsg-guard
```

## 開発セッション起動

新しいプロジェクト用フォルダを作り、**Claude Code を 2 ウィンドウ開きます**。
片方を設計担当、もう片方を実装担当にし、それぞれスラッシュコマンドを打つだけで体制が立ち上がります。

```text
ウィンドウ1: /opus     ← 設計担当として起動（roles/designer.md を読み込む）
ウィンドウ2: /sonnet   ← 実装担当として起動（roles/implementer.md を読み込む）
```

`/opus`・`/sonnet` の実体は `~/.claude/commands/opus.md`・`sonnet.md`（グローバルコマンド）で、
内部で `~/dev/agmsg-guard/setup-role.sh --role <opus|sonnet>` を実行します。

`/opus` または `/sonnet` を最初に打った時点で、`setup-role.sh` が次を自動で行います:

1. agmsg / agmsg-guard の存在確認（未インストールならクローン手順を案内して終了）
2. チーム名検出（`.agmsg-team` ファイル → 無ければカレントディレクトリ名から推定）
3. チーム未初期化なら `init-dev-team.sh` を自動実行（join・ルール送信・CLAUDE.md 追記・`.agmsg-team` 作成）
4. 役割ルールファイルの場所を案内
5. **チーム別の guard-daemon** を起動（既に起動中ならスキップ）

そのため、**1 つ目のウィンドウで `/opus` を打てばチームと guard がまるごと立ち上がり**、
2 つ目で `/sonnet` を打つと「初期化済み」として検出され、実装担当として参加します。

> **複数プロジェクトの並行運用**: guard-daemon の PID ファイルは
> `~/.agents/agmsg/run/guard-daemon-<team>.pid` のように **チーム別** です。
> プロジェクトごとにチーム名が異なれば、それぞれ独立した guard が並行して動きます。
> → 別プロジェクトを開くときはフォルダ（=チーム名）を分けること。同名チームだと guard が共有されます。
>
> **同フォルダで opus/sonnet を動かす場合の注意**: opus と sonnet を同じフォルダで起動すると、
> agmsg の identity が同一プロジェクトパスに 2 つ登録されます。動作はしますが、混乱を避けるため
> **2 つのウィンドウで同じプロジェクトフォルダを開く**運用を基本とし、`/opus`・`/sonnet` で役割を明示してください。

## 新規プロジェクト手順

基本は「フォルダを作り、2 ウィンドウで `/opus`・`/sonnet` を打つ」だけです。

```text
1. プロジェクト用フォルダを作成（git init・初回コミットは README.md の手順参照）
2. ウィンドウ1（設計担当）でそのフォルダを開き、/opus を実行
   → チーム作成・join・ルール送信・CLAUDE.md 追記・guard 起動まで自動
3. ウィンドウ2（実装担当）で同じフォルダを開き、/sonnet を実行
   → 「初期化済み」として検出され、実装担当として参加
4. ユーザが Opus ウィンドウに設計タスクを伝える
```

チーム名は、フォルダ内に `.agmsg-team` があればそれを、無ければフォルダ名から自動で決まります。
明示したい場合は、フォルダに `.agmsg-team`（中身はチーム名 1 行）を置いてから `/opus` を打ちます。

### 内部で何が起きるか（手動実行は不要）

`/opus`・`/sonnet` → `setup-role.sh` → 未初期化なら `init-dev-team.sh` が走り、次を行います:

- agmsg チームに opus/sonnet を登録
- ロールルールをチームに送信（べき等: 重複送信しない）
- プロジェクトの `CLAUDE.md` に agmsg 協働ルール節を追記
- `.agmsg-team` マーカーを作成
- **チーム別の** `guard-daemon.sh` を起動（そのチームの guard が未起動の場合のみ）

手動で初期化したい場合のみ、次を直接実行できます（通常は不要）:

```bash
bash ~/dev/agmsg-guard/init-dev-team.sh --team <TEAM> --project <PATH>
```

ロールルールの場所: `~/dev/agmsg-guard/roles/`

- `designer.md` — 設計担当（Opus）向けルール
- `implementer.md` — 実装担当（Sonnet）向けルール

### guard-daemon の停止

guard を手動で止めたいときは、チーム別 PID ファイルから停止します:

```bash
# 特定チームの guard を停止
kill "$(cat ~/.agents/agmsg/run/guard-daemon-<TEAM>.pid)"

# 稼働中の guard-daemon を一覧
ls ~/.agents/agmsg/run/guard-daemon-*.pid
```

通常は wall-timeout（既定 3600 秒）到達で自然終了するため、明示停止は任意です。

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

## DB メンテナンス

メッセージ DB が肥大化した場合は `db-maintenance.sh` を使用:

```bash
bash ~/dev/agmsg-guard/db-maintenance.sh --status               # DB サイズ・件数確認
bash ~/dev/agmsg-guard/db-maintenance.sh --archive 30  # 30日以上前をアーカイブ
bash ~/dev/agmsg-guard/db-maintenance.sh --purge 90    # 90日以上前を削除
bash ~/dev/agmsg-guard/db-maintenance.sh --vacuum       # DB 圧縮
```

## 参照ドキュメント

- `~/dev/agmsg-guard/README.md` — guard.sh の全オプションと使用例
- `docs/team_ops/claude_code_design_role.md` — 設計担当（Opus）の役割定義
- `docs/team_ops/claude_code_role.md` — 実装担当（Sonnet）の役割定義

---

**最終更新**: 2026-06-14
