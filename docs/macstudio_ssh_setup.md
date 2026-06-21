# 職場 MacStudio への SSH 接続手順

> 自宅 MacBook Pro から職場 MacStudio へ鍵認証で接続する設定の記録。
> 設定日: 2026-06-21

## 接続先の基本情報

| 項目 | 値 |
|---|---|
| SSH エイリアス | `work-mac`（`ssh work-mac` で入れる） |
| Tailscale ホスト名 | `y-tsuji-macstudio2023` |
| Tailscale IP | `100.115.81.67` |
| 実ホスト名 | `428-sv5.fun.ac.jp`（公立はこだて未来大） |
| **ユーザー名** | **`yoshihitotsuji`（ハイフン無し）** |
| 認証鍵 | `~/.ssh/id_ed25519`（comment: tsuji.yoshihito@gmail.com） |

> ⚠️ **罠**: ユーザー名は `yoshihitotsuji`。`yoshihito-tsuji`（ハイフン入り）だと認証が通らない。

## 接続コマンド

```bash
ssh work-mac
```

## ~/.ssh/config の設定（自宅 MacBook Pro に登録済み）

```
Host work-mac
    HostName y-tsuji-macstudio2023
    User yoshihitotsuji
    IdentityFile ~/.ssh/id_ed25519
```

## 別PCから新しく接続できるようにする手順

MacStudio へのパスワード認証が面倒/通らないときは、**既にアクセスできる hitotose を踏み台**にして
新しいPCの公開鍵を MacStudio に登録するのが速い。

### 前提
- 新PCに SSH 鍵があること（無ければ `ssh-keygen -t ed25519`）
- 新PCから hitotose に SSH で入れること（Tailscale + 鍵登録済み）
- hitotose 側に `work-mac` エイリアス（User yoshihitotsuji, HostName 100.115.81.67）が登録済みで、
  hitotose → MacStudio がパスワード無しで通ること

### 手順

新PC上で実行（自分の公開鍵を hitotose 経由で MacStudio の authorized_keys に追記）:

```bash
cat ~/.ssh/id_ed25519.pub | ssh hitotose \
  'ssh work-mac "umask 077; mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"'
```

その後、新PCの `~/.ssh/config` に上記 `Host work-mac` ブロックを追記すれば `ssh work-mac` で入れる。

## 経路についてのメモ

- 接続経路は Tailscale。設定時点では DERP リレー（東京）経由だった。
- MacStudio と同一 LAN にいれば P2P 直結に自動で切り替わる。
- 状態確認: `tailscale ping 100.115.81.67`

## 関連

- hitotose 接続手順は別途記録（Tailscale + SSH + mosh、ユーザー `shimotsuki`）。
