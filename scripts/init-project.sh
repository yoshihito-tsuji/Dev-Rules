#!/bin/bash
# init-project.sh — Dev-Rules プロジェクト初期化スクリプト
#
# Usage:
#   bash ~/Claude_Code/Dev-Rules/scripts/init-project.sh <ProjectName>
#
# 生成されるもの:
#   ~/Claude_Code/<ProjectName>/
#   ├── CLAUDE.md              (TEMPLATE_CLAUDE.md から生成)
#   ├── DECISIONS.md
#   ├── README.md              (プレースホルダー)
#   ├── LOG/YYYY-MM-DD.md      (初日ログ)
#   └── docs/team_ops/
#       └── claude_code_role.md

set -euo pipefail

# ─────────────────────────────────────────
# 引数チェック
# ─────────────────────────────────────────
PROJECT_NAME="${1:-}"
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: プロジェクト名を指定してください。"
  echo "Usage: $0 <ProjectName>"
  echo "Example: $0 MyNewApp"
  exit 1
fi

BASE_DIR="$HOME/Claude_Code"
DEV_RULES_DIR="$HOME/Claude_Code/Dev-Rules"
PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"
TODAY=$(date +%Y-%m-%d)

# ─────────────────────────────────────────
# 既存チェック
# ─────────────────────────────────────────
if [ -d "$PROJECT_DIR" ]; then
  echo "Error: ディレクトリが既に存在します: $PROJECT_DIR"
  exit 1
fi

echo "プロジェクトを初期化します: $PROJECT_NAME"
echo "場所: $PROJECT_DIR"
echo ""

# ─────────────────────────────────────────
# ディレクトリ作成
# ─────────────────────────────────────────
mkdir -p "$PROJECT_DIR/docs/team_ops"
mkdir -p "$PROJECT_DIR/LOG"

# ─────────────────────────────────────────
# CLAUDE.md (テンプレートから生成)
# ─────────────────────────────────────────
sed "s/\[プロジェクト名\]/$PROJECT_NAME/g" \
  "$DEV_RULES_DIR/TEMPLATE_CLAUDE.md" \
  > "$PROJECT_DIR/CLAUDE.md"

# ─────────────────────────────────────────
# DECISIONS.md
# ─────────────────────────────────────────
cat > "$PROJECT_DIR/DECISIONS.md" << EOF
# 重要な決定事項

このファイルには、プロジェクトの重要な決定事項を1行形式で記録します。
日次ログ（\`LOG/YYYY-MM-DD.md\`）の \`[DECISION]\` セクションから重要な確定事項を抽出して転記してください。

**記録形式**: \`- YYYY-MM-DD: [決定内容を1行で記載]\`

---

## 決定事項一覧

- $TODAY: プロジェクト初期化（init-project.sh による自動生成）
EOF

# ─────────────────────────────────────────
# LOG/TODAY.md
# ─────────────────────────────────────────
cat > "$PROJECT_DIR/LOG/$TODAY.md" << EOF
# LOG — $TODAY

---

## [LOG_00001] セッション開始

プロジェクト \`$PROJECT_NAME\` の初期化を実施。
init-project.sh (Dev-Rules) により自動生成。

---
EOF

# ─────────────────────────────────────────
# docs/team_ops/claude_code_role.md
# ─────────────────────────────────────────
cat > "$PROJECT_DIR/docs/team_ops/claude_code_role.md" << 'ROLE_EOF'
# Claude Code 役割定義

> 三者協働開発（Yoshihitoさん + Codex + Claude Code）の役割定義。
> グローバルルールは `~/.claude/CLAUDE.md` に定義済み。ここではプロジェクト固有の補足のみ記載。

---

## 役割

- **設計**: Codex
- **実装・テスト**: Claude Code
- **方針・最終判断**: Yoshihitoさん

## コミュニケーション形式（必須）

```
From: Claude Code
To: Yoshihitoさん

本文はここから開始します。
```

- AI間・ユーザへの報告は必ず `From: / To:` 形式
- 作業内容は `LOG/YYYY-MM-DD.md` に追記（`[PROPOSAL]` `[RUNLOG]` `[DECISION]` セクション）

## 起動時手順

1. `CLAUDE.md` を読む — プロジェクト概要・フェーズを把握
2. `DECISIONS.md` を確認 — 確定事項を把握
3. `LOG/YYYY-MM-DD.md` を確認 — 直近の作業を把握（今日のファイルがなければ作成）
4. `README.md` を精読 — 詳細を理解

## 参照先

- 三者協働ルール全文: `../../Dev-Rules/README.md`
- グローバルルール: `~/.claude/CLAUDE.md`
ROLE_EOF

# ─────────────────────────────────────────
# README.md (プレースホルダー)
# ─────────────────────────────────────────
cat > "$PROJECT_DIR/README.md" << EOF
# $PROJECT_NAME

> **このファイルはプロジェクト正本（README.md）のプレースホルダーです。内容を更新してください。**

---

## 概要

[プロジェクトの目的・背景を記載]

## 技術スタック

[使用技術を記載]

## セットアップ

\`\`\`bash
# セットアップコマンドを記載
\`\`\`

## 開発ルール

三者協働開発（Yoshihitoさん + Codex + Claude Code）で進行。
詳細は \`../Dev-Rules/README.md\` を参照。

---

*このファイルは init-project.sh により $TODAY に自動生成されました。*
EOF

# ─────────────────────────────────────────
# Git 初期化
# ─────────────────────────────────────────
cd "$PROJECT_DIR"
git init -q
git add .
git commit -q -m "Initial commit: project scaffold via Dev-Rules/init-project.sh"

echo "完了しました。"
echo ""
echo "作成されたファイル:"
echo "  $PROJECT_DIR/CLAUDE.md"
echo "  $PROJECT_DIR/DECISIONS.md"
echo "  $PROJECT_DIR/README.md"
echo "  $PROJECT_DIR/LOG/$TODAY.md"
echo "  $PROJECT_DIR/docs/team_ops/claude_code_role.md"
echo ""
echo "次のステップ:"
echo "  1. CLAUDE.md を編集 — 技術スタック・フェーズを記入"
echo "  2. README.md を編集 — プロジェクト概要を記述"
echo "  3. GitHub でリポジトリを作成して push"
echo "  4. Codex に設計を依頼"
