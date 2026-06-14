# Dev-Rules: 四者協働開発方法論アーカイブ

**Four-Party Collaborative Development Methodology Archive**

このリポジトリは、Yoshihitoさんのすべてのプロジェクトで使用する協働開発方法論の永続的なアーカイブです。

> **2026-06-14 更新**: Claude Code Opus（設計担当）+ Claude Code Sonnet（実装担当）+ agmsg+agmsg-guard（エージェント間通信基盤）による二者協働体制へ移行しました。詳細は本ドキュメント「協働体制」セクション、および各役割定義（[docs/team_ops/](docs/team_ops/)）を参照してください。

---

## 🚨 重要：AI担当者への最優先指示

**このREADME.mdを最初から最後まで必ず精読してください。**

### 🤖 AI起動時の自動読み込み指示

**あなた（AI）がこのREADME.mdを読んだら、必ず以下を実行してください：**

#### Claude Code Opus（設計担当）の場合

1. 次に `docs/team_ops/claude_code_design_role.md` を読んでください
2. その後、そのファイルに記載された起動手順に従ってください

#### Claude Code Sonnet（実装担当）の場合

1. 次に `docs/team_ops/claude_code_role.md` を読んでください
2. その後、そのファイルに記載された起動手順に従ってください

**重要**: 役割定義ファイルを読んだ後、そこに記載された手順（DECISIONS.md、LOGの確認等）を必ず実行してください。

---

### 📋 AI起動時の必須手順（概要）

1. **README.md精読** → プロジェクト全体像を把握
2. **役割定義確認** → `docs/team_ops/codex_role.md` または `claude_code_role.md` を確認
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

---

## 📖 目次

1. [開発理念](#開発理念)
2. [協働体制（四者協働）](#協働体制)
3. [役割定義](#役割定義)
4. [コミュニケーションルール](#コミュニケーションルール)
5. [ドキュメント管理](#ドキュメント管理)
6. [ワークフロー](#ワークフロー)
7. [新規プロジェクト立ち上げ手順](#新規プロジェクト立ち上げ手順)
8. [Claude Code Best Practice](#claude-code-best-practice)

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
- **役割の明確化**: Codex（設計・実装案）、Claude Code（実装）、xangi システム / LOCO（相談役・整理・追加確認）、Yoshihito さん（最終決定）
- **非同期協働**: 各担当者が独立して作業できる体制
- **段階的開発**: 小さく始めて、段階的に拡張

---

## 🤝 協働体制

### 基本体制（三者間共同開発）

| 担当 | 役割 |
|------|------|
| **Yoshihitoさん（ユーザ）** | プロダクトオーナー。要件定義・最終承認・必要に応じて検証 |
| **Claude Code Opus（設計担当）** | アーキテクチャ設計・仕様策定・agmsg経由でSonnetに渡す |
| **Claude Code Sonnet（実装担当）** | 設計に従い実装・テスト・DONE送信 |

### 補助メンバー（必要時のみ参加）

| 担当 | 参加条件 |
|------|---------|
| **Codex** | 三者で解決困難な問題が発生した場合、Opusが積極的に協力を要請できる。設計上の難問・外部ライブラリの深掘りなど |
| **xangi システム（LOCO）** | ユーザが検証・状況整理を行う際に利用。Codexと並列で活用可 |

### 対話ルール

- agmsg 経由でOpus⇔Sonnet間のメッセージをやり取り
- **標準: 10往復以内での収束**（agmsg-guardのデフォルト上限: 20往復）
- DONE / STOPシグナルで協議終了
- 三者間で解決できない場合: OpusがCodexに仕様相談 → 回答をSonnetに転送

### エスカレーション手順

1. Opus・Sonnet間で2往復以内に解決しない技術的難問が出た場合
2. OpusがCodexに問い合わせ（Codex側のセッションで直接相談）
3. Codexの回答を踏まえてOpusが仕様を確定し、Sonnetに再送
4. ユーザへの報告: エスカレーションした事実とその結果を明記

詳細手順: [`docs/team_ops/escalation_guide.md`](docs/team_ops/escalation_guide.md)

### 重要ルール

1. **顧客は Yoshihitoさん**: 管理権限は常にここ。AI 側で勝手に方針を決めない、スコープを広げない
2. **すべて日本語で記述**: AI応答、コメント、ドキュメントは必ず日本語で記述すること
3. **設計なしに実装しない**: 新機能や大きな変更は必ず Opus の設計を経由
4. **実装は設計に基づく**: Sonnet は Opus の仕様に基づいて実装
5. **10往復以内での収束**: agmsg でのやり取りは標準10往復以内を基準とする
6. **すべてを記録する**: 決定事項、提案、実装内容をドキュメント化

---

## 👥 役割定義

### Codex（設計・実装案担当AI）

#### 責務

- 要件を分析し、システムアーキテクチャを設計
- 技術選定と実装方針の提案
- 実装計画（ファイル構成、モジュール分割、優先順位）の策定
- Claude Code への実装指示書作成（ノート / PR / コメント形式で非同期に残す）

#### 成果物

- 設計書（`docs/design/` 配下）
- 実装計画書
- アーキテクチャ図（必要に応じて）
- Claude Code への実装指示

#### コミュニケーション形式

```
From: Codex
To: [Yoshihito さん / Claude Code]

[内容]

【設計方針】
- [方針1]
- [方針2]

【確認事項】
- [確認したい点]
```

#### 起動手順

`docs/team_ops/codex_role.md` を参照  
初回認識や共通運用方針は `CODEX_ONBOARDING.md` も参照

---

### xangi システム / LOCO（Xangi 上で動作する相談役 AI、通称「ロコ」）

#### 責務

- Yoshihito さんの隣にいる**詳しい相談役**として、技術アドバイス・状況確認・要件のかみ砕きを行う
- Codex / Claude Code の説明や方針を整理し、Yoshihito さんが判断しやすい形で要約・報告する
- Codex / Claude Code の作業状況を必要に応じて確認し、Yoshihito さんへ共有する
- Yoshihito さんからの追加要望を Codex / Claude Code に中継する
- 自分自身で実装・設計を巻き取らない（軽量な調査・コマンド実行は可）
- 追加確認役として、曖昧な点の確認、再説明、影響範囲の点検も担う

#### 成果物

- Xangi 上の対話ログ（xangi リポの `memory/` ディレクトリで管理）
- Yoshihito さんへの状況報告・選択肢提示
- Codex / Claude Code 側ログへの反映依頼

#### コミュニケーション形式

```
From: xangi システム
To: [Yoshihito さん / Codex / Claude Code]

[本文]
```

Discord 上のカジュアル対話では From/To は省略可（文脈から明確）。

#### 起動手順

`docs/team_ops/xangi_system_role.md` を参照  
xangi リポ固有の運用は [xangi/docs/dev-methodology.md](https://github.com/yoshihito-tsuji/xangi/blob/main/docs/dev-methodology.md) を参照

---

### Claude Code（プランモード・補助的な設計担当）

> 旧体制（2026-03-31 〜 2026-05-19）で主担当を担っていましたが、現在は Codex が主担当に戻ったため**補助的な位置づけ**です。Codex 不在時や軽量な設計タスクで利用します。

詳細は `docs/team_ops/claude_code_design_role.md` を参照。

---

### Claude Code（実装担当AI）

#### 責務

- Codex の設計書に基づいてコードを実装
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
- Claude Code（設計）の設計提案の承認・却下
- Claude Codeの実装結果の確認
- 重要な技術選定の最終判断

#### 意思決定の記録

- 重要な決定事項は `DECISIONS.md` に記録
- 日次の作業履歴は `LOG/YYYY-MM-DD.md` に記録

---

## 💬 コミュニケーションルール

### 言語に関する原則

**重要: すべての対話は日本語で行います。**

- **AI（Claude Code）からのメッセージは必ず日本語で記述**してください
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
From: Claude Code（設計）
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
├── README.md                          # プロジェクト概要（協働ルールを含む）
├── DECISIONS.md                       # 重要な決定事項の記録
├── KNOWN_ISSUES.md                    # 既知の問題と解決策
├── docs/
│   ├── team_ops/
│   │   ├── claude_code_design_role.md # 設計担当Claude Codeの役割定義
│   │   ├── claude_code_role.md        # 実装担当Claude Codeの役割定義
│   │   └── LOG_TEMPLATE.md            # ログテンプレート
│   ├── design/                        # 設計担当Claude Codeの設計書
│   └── SETUP_GUIDE.md                 # 環境構築手順
└── LOG/
    └── YYYY-MM-DD.md                  # 日次作業ログ
```

### README.mdの必須内容

1. プロジェクト概要
2. 🚨 AI担当者への最優先指示（協働ルール）
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

### KNOWN_ISSUES.mdの記録形式

過去に発生した問題と解決策を記録する。AI担当者が同じ問題を繰り返さないための「組織の記憶」。
原因の特定に時間がかかった問題を優先的に記録する。「2回同じ説明をしたら書き下ろす」をルールとする。

重大度（Critical / Warning / Info）とステータス（未解決 / 解決済み）で分類し、問題が増えても優先度を把握しやすくする。

```markdown
### [問題の短い説明]

- **重大度**: Critical / Warning / Info
- **ステータス**: 🔴 未解決 / 🟢 解決済み
- **発生日**: YYYY-MM-DD
- **症状**: 何が起きたか（ユーザーから見える現象）
- **原因**: なぜ起きたか（根本原因）
- **解決策**: どう直したか（具体的な修正内容）
- **該当ファイル**: `path/to/file` の `function_name()`
- **再発防止**: AI担当者が今後注意すべきこと
```

テンプレートは [TEMPLATE_KNOWN_ISSUES.md](TEMPLATE_KNOWN_ISSUES.md) を参照。

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

1. **Yoshihito さん**: 要件を Opus に伝える
2. **Opus（設計担当）**:
   - 要件を分析し、仕様を策定
   - agmsg 経由で Sonnet に仕様を送信（5往復以内での収束を目標）
3. **Sonnet（実装担当）**:
   - Opus の仕様に従って実装
   - テスト実行・確認
   - ログ記録（`LOG/YYYY-MM-DD.md`）
   - Git commit
   - 完了後 agmsg で `DONE` を送信
4. **agmsg-guard**: 対話を監視し、上限超過・タイムアウトで自動停止
5. **Yoshihito さん**: 実装結果を確認・承認

### バグ修正フロー

1. **Yoshihito さん**: バグ内容を Opus または Sonnet に伝える
2. **Opus（設計担当）**:
   - 軽微なバグ: Sonnet に直接修正を指示（agmsg 経由）
   - 設計変更が必要: 修正方針を設計し Yoshihito さんに承認依頼
3. **Sonnet（実装担当）**: 修正実装・テスト・ログ記録・`DONE` 送信
4. **Yoshihito さん**: 修正結果を確認

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

### 0. Claude Codeグローバル設定（PC初回のみ）

新しいPCでClaude Codeを使い始めるとき、グローバルCLAUDE.mdを配置してください。
この設定は全プロジェクト共通で自動読み込みされます。

```bash
# Dev-Rulesをクローン（まだの場合）
cd ~/Claude_Code
git clone https://github.com/yoshihito-tsuji/Dev-Rules.git

# グローバルCLAUDE.mdを配置
mkdir -p ~/.claude
cp ~/Claude_Code/Dev-Rules/setup/global-claude-md.md ~/.claude/CLAUDE.md
```

グローバルCLAUDE.mdを更新した場合は、Dev-Rulesに同期してください：

```bash
cp ~/.claude/CLAUDE.md ~/Claude_Code/Dev-Rules/setup/global-claude-md.md
cd ~/Claude_Code/Dev-Rules && gacp "Update: グローバルCLAUDE.mdテンプレートを同期"
```

### 1. リポジトリ作成

```bash
mkdir project-name
cd project-name
git init
```

### 2. Dev-Rulesからテンプレートをコピー

```bash
# このリポジトリをクローン（まだの場合）
git clone https://github.com/yoshihito-tsuji/Dev-Rules.git

# テンプレートファイルをコピー
cp Dev-Rules/TEMPLATE_README.md ./README.md
cp Dev-Rules/TEMPLATE_KNOWN_ISSUES.md ./KNOWN_ISSUES.md
cp -r Dev-Rules/docs ./
mkdir LOG
```

### 3. README.mdをカスタマイズ

- プロジェクト名
- 技術スタック
- 目的・概要
- ハードウェア構成（該当する場合）

### 4. docs/team_ops/ に役割定義をコピー

```bash
cp Dev-Rules/docs/team_ops/claude_code_design_role.md ./docs/team_ops/
cp Dev-Rules/docs/team_ops/claude_code_role.md ./docs/team_ops/
```

### 5. 初回コミット

```bash
git add .
git commit -m "Initial commit: Project setup with Dev-Rules methodology"
git remote add origin https://github.com/yoshihito-tsuji/project-name.git
git push -u origin main
```

### 6. agmsg チーム初期化（三者間協働開発体制）

```bash
bash ~/dev/agmsg-guard/init-dev-team.sh --team <TEAM> --project $(pwd)
```

これにより以下が一括セットアップされます:
- agmsg チームに opus/sonnet を登録
- ロールルール送信・プロジェクト CLAUDE.md への agmsg 協働節の追記
- `guard-daemon.sh` 起動

その後、Claude Code を 2 ウィンドウ開いてそれぞれ `/opus`、`/sonnet` を実行するとセッションが準備完了します。  
詳細: `docs/team_ops/agmsg_system.md`

### 7. Codex で設計開始

Codex（VSCode 等）を起動し、`CODEX_START.md`（プロジェクト固有の起動プロンプト）または `CODEX_ONBOARDING.md` に従って設計作業を開始

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
- [TEMPLATE_CLAUDE.md](TEMPLATE_CLAUDE.md) - プロジェクトCLAUDE.mdテンプレート（AI起動時の自動読み込み用、60〜100行目標）
- [TEMPLATE_KNOWN_ISSUES.md](TEMPLATE_KNOWN_ISSUES.md) - 既知の問題と解決策テンプレート
- [setup/global-claude-md.md](setup/global-claude-md.md) - Claude CodeグローバルCLAUDE.mdテンプレート（`~/.claude/CLAUDE.md`用）
- [docs/team_ops/codex_role.md](docs/team_ops/codex_role.md) - Codex（設計・実装案担当）役割定義
- [docs/team_ops/xangi_system_role.md](docs/team_ops/xangi_system_role.md) - xangi システム / LOCO（相談役・整理役）役割定義
- [docs/team_ops/claude_code_role.md](docs/team_ops/claude_code_role.md) - Claude Code（実装担当）役割定義
- [docs/team_ops/claude_code_design_role.md](docs/team_ops/claude_code_design_role.md) - Claude Code（プランモード・補助）役割定義
- [docs/team_ops/design_handoff_report_2026-03-31.md](docs/team_ops/design_handoff_report_2026-03-31.md) - 2026-03-31 設計担当移行レポート（参考、現在は Codex 復活）
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

**Q: Codex とは何ですか？**
A: VSCode 等で動作する AI コーディング環境で、設計・アーキテクチャ・実装案の策定を担当します。Claude Code への実装指示書をノート / PR / コメント形式で残します。

**Q: Claude Code とは何ですか？**
A: Anthropic の Claude Code CLI（このツール）で、Codex の設計に基づいた実装を担当します。VSCode 拡張として動作します。

**Q: xangi システムとは何ですか？**
A: Xangi 上で動作する AI アシスタントで、通称は LOCO（ロコ）です。Yoshihito さんの**詳しい相談役**として機能し、Codex / Claude Code の説明をかみ砕いて整理し、作業状況の確認や追加要望の中継、追加確認を担います。

**Q: Codex と Claude Code は直接やり取りしないのですか？**
A: 基本的に**非同期協働**です。Codex がノート / PR / コメントで設計案を残し、Claude Code がそれを読んで実装します。質問が必要な場合は Yoshihito さん経由で伝達します（A 方式）。

**Q: Claude Code（プランモード）の位置づけは？**
A: 2026-03-31 〜 2026-05-19 の間は設計の主担当でしたが、現在は Codex を主担当に戻したため**補助的な位置づけ**です。Codex 不在時や軽量な設計タスクで利用します。

**Q: なぜFrom/To形式を使うのですか？**
A: 誰が誰に向けて話しているかを明確にし、コミュニケーションの混乱を防ぐためです。役割が増えても、From/To を残すことで意図と責任範囲を見失いにくくなります。

**Q: LOGとDECISIONSの違いは？**
A: LOGは日次の作業履歴、DECISIONSは重要な決定事項の永続記録です。

**Q: KNOWN_ISSUESとは？**
A: 過去に発生した問題と解決策の記録です。AI担当者が同じ問題を繰り返さないための「組織の記憶」として機能します。LOGが「何をしたか」、DECISIONSが「何を決めたか」、KNOWN_ISSUESが「何が壊れてどう直したか」を記録します。

---

## 📄 ライセンス

このDev-Rules方法論は、Yoshihitoさんのプロジェクトで自由に使用できます。

---

## 📚 Claude Code Best Practice

### 概要

このリポジトリには、Claude Code（Anthropic公式CLI）を効果的に活用するためのベストプラクティス集が統合されています。Claude Code担当者（実装AI）は、この資料を参照することで、より高度な自動化とワークフロー最適化が可能になります。

### 配置場所

[`claude-code/`](claude-code/) ディレクトリに、以下の内容が含まれています：

- **Skills（スキル）**: 再利用可能な知識とワークフロー（`.claude/skills/`）
- **Subagents（サブエージェント）**: 独立した実行コンテキスト（`.claude/agents/`）
- **Hooks（フック）**: イベント駆動型スクリプト（`.claude/hooks/`）
- **Reports（レポート）**: 実践的な調査レポート（`reports/`）
- **Workflows（ワークフロー）**: 実装例とパターン（`workflow/`）

### 主要なベストプラクティス

#### ワークフロー設計

- **CLAUDE.mdは150行以下に**: 指示遵守率を高めるため、簡潔に保つ
- **コマンド→エージェント→スキル**: 再利用可能な3層アーキテクチャを採用
- **プランモードから開始**: 複雑なタスクは実装前に計画を立てる
- **こまめなコミット**: タスク完了後すぐにコミットして状態を保存

#### 効率化テクニック

- **手動/compact実行**: コンテキスト使用率50%で圧縮
- **バックグラウンドタスク**: ログを確認したいコマンドはBTW（background task）で実行
- **ステータスライン**: コンテキスト使用状況を常に把握

#### デバッグ

- `/doctor`コマンドで診断
- MCPでブラウザコンソールログを確認
- スクリーンショット提供で視覚的な問題を共有

### Dev-Rulesとの統合

Claude Code Best Practiceは、Dev-Rulesの四者協働開発方法論と xangi システム / LOCO の整理・確認運用を**技術的に補完**する位置づけです：

| Dev-Rules | Claude Code Best Practice |
| --------- | ------------------------- |
| **開発プロセス**（役割分担、設計→実装フロー） | **技術実装**（自動化、効率化） |
| Claude Code（設計/実装）・Yoshihitoさん・xangi システム / LOCO の協働方法 | Claude Codeの高度な活用方法 |
| コミュニケーションルール、ドキュメント管理 | Skills、Hooks、Subagentsの実装パターン |

### 活用方法

1. **各プロジェクトのCLAUDE.mdに参照を追加**:

   ```markdown
   開発方法論: Dev-Rules参照
   Claude Code設定: Dev-Rules/claude-code/参照
   ```

2. **必要なスキルやフックをプロジェクトにコピー**:

   ```bash
   cp -r Dev-Rules/claude-code/.claude/skills/weather-fetcher myproject/.claude/skills/
   ```

3. **サブエージェントの設計パターンを参考にする**:
   [`claude-code/.claude/agents/`](claude-code/.claude/agents/)の実装例を確認

### 詳細ドキュメント

- 設計担当Claude Code向けガイド: [`docs/team_ops/claude_code_design_role.md`](docs/team_ops/claude_code_design_role.md)
- 体制変更引き継ぎレポート: [`docs/team_ops/design_handoff_report_2026-03-31.md`](docs/team_ops/design_handoff_report_2026-03-31.md)
- Claude Code Best Practice完全ガイド: [`claude-code/README.md`](claude-code/README.md)

---

**最終更新**: 2026-05-29
**バージョン**: 2.1.0
