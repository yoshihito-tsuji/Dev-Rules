#!/usr/bin/env bash
# Dev-Rules インストーラ
# 使用法: bash setup/install.sh [--force] [-h|--help]
#
# 新しいPCで agmsg+guard 二者協働体制を再現するためのセットアップスクリプト。
# 冪等: 既存ファイルはスキップ（--force で上書き）。何度実行しても安全。

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORCE=false

# --- 引数解析 ---
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    -h|--help)
      echo "使用法: bash setup/install.sh [--force] [-h|--help]"
      echo ""
      echo "オプション:"
      echo "  --force   既存ファイルを上書きする"
      echo "  -h/--help このヘルプを表示"
      exit 0
      ;;
    *) echo "不明なオプション: $arg" >&2; exit 1 ;;
  esac
done

# --- ヘルパー ---
ok()   { echo "  ✅ $*"; }
skip() { echo "  ⏭  既存: スキップ (--force で上書き): $*"; }
copy() { echo "  📄 コピー: $*"; }
over() { echo "  🔄 上書き: $*"; }
warn() { echo "  ⚠️  $*"; }
info() { echo "  ℹ️  $*"; }

# --- 1. 依存チェック ---
echo ""
echo "=== [1/4] 依存チェック ==="
MISSING=()
check_dep() {
  if command -v "$1" >/dev/null 2>&1; then
    ok "$1"
  else
    echo "  ❌ $1 が見つかりません"
    MISSING+=("$1")
  fi
}

check_dep bash
check_dep git
check_dep sqlite3

# jq または python3 どちらかあればOK
if command -v jq >/dev/null 2>&1; then
  ok "jq"
elif command -v python3 >/dev/null 2>&1; then
  ok "python3 (jq の代替として利用可)"
else
  echo "  ❌ jq または python3 が見つかりません"
  MISSING+=("jq または python3")
fi

if [ ${#MISSING[@]} -gt 0 ]; then
  echo ""
  echo "以下の依存が不足しています:"
  for dep in "${MISSING[@]}"; do
    echo "  - $dep"
  done
  echo ""
  echo "macOS: brew install jq sqlite3"
  echo "Linux: sudo apt install jq sqlite3"
  echo ""
  echo "依存を導入してから再実行してください。"
  exit 1
fi

# --- 2. agmsg-guard clone or pull ---
echo ""
echo "=== [2/4] agmsg-guard ==="
AGMSG_GUARD_DIR="$HOME/dev/agmsg-guard"
AGMSG_GUARD_REPO="https://github.com/yoshihito-tsuji/agmsg-guard.git"

if [ -d "$AGMSG_GUARD_DIR/.git" ]; then
  info "agmsg-guard は既に存在します。最新に更新します..."
  if git -C "$AGMSG_GUARD_DIR" pull --ff-only 2>/dev/null; then
    ok "agmsg-guard を更新しました: $AGMSG_GUARD_DIR"
  else
    warn "agmsg-guard の pull に失敗しました（ローカル変更があるかもしれません）。スキップして続行します。"
  fi
elif [ -d "$AGMSG_GUARD_DIR" ]; then
  warn "$AGMSG_GUARD_DIR は存在しますが git リポジトリではありません。スキップします。"
else
  info "agmsg-guard をクローンします..."
  mkdir -p "$HOME/dev"
  if git clone "$AGMSG_GUARD_REPO" "$AGMSG_GUARD_DIR" 2>/dev/null; then
    ok "agmsg-guard をクローンしました: $AGMSG_GUARD_DIR"
  else
    warn "agmsg-guard のクローンに失敗しました（認証/権限/ネットワークを確認）。手動で git clone してください。スキップして続行します。"
    warn "手動: git clone $AGMSG_GUARD_REPO $AGMSG_GUARD_DIR"
  fi
fi

# --- 3. /opus・/sonnet コマンドをコピー ---
echo ""
echo "=== [3/4] Claude Code コマンド (~/.claude/commands/) ==="
COMMANDS_SRC="$SCRIPT_DIR/commands"
COMMANDS_DST="$HOME/.claude/commands"

mkdir -p "$COMMANDS_DST"

for src_file in "$COMMANDS_SRC"/*.md; do
  filename="$(basename "$src_file")"
  dst_file="$COMMANDS_DST/$filename"

  if [ -f "$dst_file" ] && [ "$FORCE" = false ]; then
    skip "$filename"
  else
    if [ -f "$dst_file" ]; then
      over "$filename"
    else
      copy "$filename"
    fi
    cp "$src_file" "$dst_file"
  fi
done

# --- 4. agmsg 本体の存在チェック ---
echo ""
echo "=== [4/4] agmsg 本体 ==="
AGMSG_DIR="$HOME/.agents/skills/agmsg"
if [ -d "$AGMSG_DIR" ]; then
  ok "agmsg が見つかりました: $AGMSG_DIR"
else
  warn "agmsg 未導入: $AGMSG_DIR が見つかりません"
  info "agmsg は別途インストールが必要です。"
  info "インストール手順は Dev-Rules/docs/team_ops/agmsg_system.md を参照してください。"
fi

# --- 完了メッセージ ---
echo ""
echo "==================================================="
echo "✅ セットアップ完了"
echo "==================================================="
echo ""
echo "次の手順:"
echo "  1. agmsg が未導入の場合は先にインストールしてください"
echo "  2. プロジェクトフォルダを作成 (または既存フォルダに移動)"
echo "  3. Claude Code を2ウィンドウ開く"
echo "     - 片方で /opus を実行 (設計担当)"
echo "     - もう片方で /sonnet を実行 (実装担当)"
echo ""
echo "詳細: ~/dev/Dev-Rules/docs/team_ops/agmsg_system.md"
echo ""
