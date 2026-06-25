# Discord 数式 PNG 化ブリッジ — 設計書（実装担当向け）

> **所属:** これは **dev-rules（team `ch-dev`）のコード実装タスク**。aruha_ch（team aruha-ch）の対話作業ではない。
> ただし編集対象ファイルは aruha_ch リポジトリ配下（`bridge/step3/` と `bin/`）にある。
> **設計担当（opus）が確定した仕様。実装はこの境界どおりに。**

## 1. 背景と要望

Discord であるはに数式を頼むと、応答が LaTeX ソースのまま見える（KaTeX プレビューは VSCode 側の運用で、Discord には届かない）。繁分数などを **PNG にして Discord に直接出したい**。

## 2. 現状の壁（2つ）と、それを回避する設計方針

| 壁 | 実体 | 本設計での扱い |
|----|------|----------------|
| ① send-reply がテキスト専用 | `bridge/step3/send-reply.sh:49` が `{content:$c}` JSON のみ。multipart 添付の口なし | `--image` を**追加**（既存テキスト経路は温存） |
| ② ブリッジ permguard が Write を `memory/` 限定 | これは **bridge の中（あるは側）** の制約 | **レンダリングを bridge の外（bot 側）に置く**ことで回避。あるは側は一切ファイルを書かない |

**核心（方針 D）:** bot.sh / send-reply.sh / tex2png.sh は "ただの配管" で **Claude を呼ばず permguard の管轄外**で動く（`bridge/step3/bot.sh:2-3` の設計どおり）。
→ あるは（permguard 下）は **マーカー付きテキストを返すだけ**。レンダリングとアップロードは bot 側で完結する。**outbox 書き出しも permguard 変更も不要。**

## 3. 全体フロー

```
Discord ユーザー「この式を画像で」
  → bot.sh が bridge.sh 経由であるはに注入
  → あるはは応答本文に ⟪TEX⟫ … ⟪/TEX⟫ を埋めて返す（テキストのみ・ファイル I/O ゼロ）
  → bridge.sh が ⟪END:n⟫ 手前までを reply としてスライス（TEX ブロックは本文内なので保存される）
  → bot.sh が reply から TEX ブロックを抽出
       ├─ 説明テキスト（ブロック除去後）: 従来どおり send-reply.sh --edit で thinking を編集投稿
       └─ 各ブロック: bin/tex2png.sh で PNG 化 → send-reply.sh --image で multipart POST
  → 生成 PNG は送信後に破棄
```

## 4. 実装対象（3ファイルに限定）

### (A) `bin/tex2png.sh`（新規・レンダラ）

CLI 単体でも叩けるレンダラ。bot からは絶対パスで呼ぶ。

```
Usage: tex2png.sh [--display|--inline] [-o OUT.png] ['<latex>']
  - LaTeX は引数または stdin。--display（既定）はブロック表示、--inline は $...$ 相当。
  - -o 省略時: mktemp で PNG を作り、その絶対パスを stdout に1行出力。
  - exit 0 = 成功（PNG パスを stdout）。非0 = 失敗（理由を stderr、stdout は空）。
```

レンダリング・パイプライン:
1. `mktemp -d` の作業ディレクトリに最小 standalone 文書を生成:
   ```latex
   \documentclass[border=8pt,varwidth]{standalone}
   \usepackage{amsmath,amssymb}
   \begin{document}
   $\displaystyle <latex> $      % --inline 時は \displaystyle を外す
   \end{document}
   ```
2. **主経路:** `latex`（DVI 生成）→ `dvipng -D 200 -T tight -bg Transparent -o out.png`
   （透過・くっきり・速い。`latex` は texlive で pdflatex と同梱。`dvipng` は hitotose 確認済）
3. **フォールバック:** `latex` 不在/失敗時 `pdflatex` → `pdftoppm -png -r 200`（無ければ `convert -density 200`）

セキュリティ（**入力は Discord ユーザー由来 = 信頼しない**。多層防御）:
- `-no-shell-escape` を**固定**（`\write18` 封じ）。`-halt-on-error -interaction=nonstopmode`。
- `-output-directory` を mktemp 作業ディレクトリに限定。`TEXMFOUTPUT` も同ディレクトリ。
- 全コンパイルを `timeout 15` で囲む（無限ループ/巨大展開対策）。
- `openin_any=p openout_any=p` を env で渡し、外部ファイル読み書きを抑止。
- 入力長を制限（例: 2000 字超は拒否し非0 exit）。改行は許可（複数行数式 OK）。
- 終了時に作業ディレクトリを必ず掃除（trap）。ネットワーク不要。

### (B) `bridge/step3/send-reply.sh` に `--image` を追加（既存経路は不変）

```
send-reply.sh --image <png> [--image <png2> ...] [<caption>]
```
- multipart POST（1メッセージに最大10枚まで）:
  ```
  curl -fsSL -X POST -H "Authorization: Bot ${DISCORD_TOKEN}" \
    -F 'payload_json={"content":"<caption>"};type=application/json' \
    -F 'files[0]=@<png1>' -F 'files[1]=@<png2>' \
    "${DISCORD_API}/channels/${DISCORD_CHANNEL_ID}/messages"
  ```
- `DISCORD_DRY_RUN=1`: 「would upload <png>（サイズ）caption=…」を stdout に出し、PNG をローカルにコピー（bot dry-run の "attachment はローカルコピー" 規約に合わせる）。
- **`--edit` との関係:** 画像は**常に新規 POST**。thinking placeholder への PATCH-attachment はやらない（テキストの `--edit` 経路は完全に不変）。
- 既存のテキスト分割ロジック（`MAX_LEN`・改行分割）は手を入れない。`--image` 指定時のみ新コードパスへ分岐する。

### (C) `bridge/step3/bot.sh` の導線（`reply` 取得後・send-reply 呼び出し前に挿入）

挿入位置: `bot.sh:278`（bridge_rc ハンドリング後）〜 `bot.sh:286`（send-reply 呼び出し）の間。

1. `reply` から **`⟪TEX⟫ … ⟪/TEX⟫`（複数行可）** ブロックを awk で全抽出 → 配列。
2. `reply_text` = reply からブロックとマーカー痕を除去したもの。
3. **ブロック 0 個** → 従来どおり `send-reply.sh --edit "$thinking_id" "$reply_text"` のみ（＝現状の `bot.sh:284-286` と同一挙動）。
4. **ブロック 1 個以上**:
   - 先に `send-reply.sh --edit "$thinking_id" "$reply_text"`（説明文を thinking へ編集投稿）。
   - 各ブロックを `bin/tex2png.sh` でレンダ → 成功した PNG を集めて `send-reply.sh --image png...` で投稿。
   - レンダ**失敗**したブロックは ⚠️ を添え、元 LaTeX をコードブロックでテキスト fallback（bot をクラッシュさせない）。
   - 生成 PNG は送信後に削除（`trash` 優先、無ければ rm）。
   - PNG の置き場は `mktemp` か `logs/bg/` 配下（`.state`/`memory` には書かない）。

### マーカー設計（END 衝突の回避）

- 採用: **`⟪TEX⟫` … `⟪/TEX⟫`**（開始・終了のペア。複数行・複数ブロック可）。
- 衝突しない根拠: END 検出は `^[[:space:]]*(● )?⟪END:<nonce>⟫[[:space:]]*$` の**単独行・nonce 厳密一致**（`bridge.sh:68`）。`⟪TEX⟫` はトークンが異なり、この正規表現に一致しない。`⟪BEGIN:n⟫`/`⟪REQ:n⟫` とも別。
- スライス保存の根拠: bridge.sh は**最後の単独 `⟪END:n⟫` 行の手前まで**を reply に切り出す（`bridge.sh:274-283`）。`⟪TEX⟫` 〜 `⟪/TEX⟫` は本文内＝END より前にあるので、reply に必ず残る。

## 5. あるは側の依存（**dev-rules 範囲外**・aruha_ch のプロンプト/スキル変更）

このプラミングが動くには、あるはが「画像化して」と頼まれたとき `⟪TEX⟫…⟪/TEX⟫` で返す振る舞いが要る。これは aruha_ch 側の **CLAUDE.md ブリッジ節 or `skills/tex-math/SKILL.md` に 1 段追記**する別タスク（コードではなくプロンプト）。本設計のコード実装とは分離する。

## 6. 受け入れ条件

1. **dry-run E2E**: `DISCORD_DRY_RUN=1` で、`⟪TEX⟫\cfrac{1}{1+\cfrac{1}{x}}⟪/TEX⟫` を含む mock 応答 → tex2png が PNG を生成し、send-reply `--image` が「would upload」＋ローカルコピーを出す。説明テキストは従来どおり `--edit`。
2. **無リグレッション**: マーカー無しの通常応答は挙動が**完全に不変**（既存テキスト経路・分割・`--edit` に変化なし）。
3. **END 不変**: `bridge.sh` は無変更。bot 側のブロック除去は END スライス**後**の `reply` body に対してのみ行う。`⟪END:n⟫` 検出・抽出に影響なし。
4. **shell-escape 封じ**: `\immediate\write18{touch /tmp/pwned}` を含む入力で**シェルが実行されない**こと（`-no-shell-escape` 固定・timeout 付き・mktemp 作業ディレクトリ限定を確認）。
5. **失敗時の堅牢性**: レンダ失敗で bot がクラッシュせず、元 LaTeX をテキスト fallback で返す。
6. **変更範囲**: `bin/tex2png.sh`（新規）・`bridge/step3/send-reply.sh`・`bridge/step3/bot.sh` の 3 ファイルのみ。`memory/`・`.secrets/`・`.state/` は非追跡のまま（push 前に `git status`/`ls-files` で確認）。

## 7. 実装前の確認事項（実装担当 → 設計担当 / Yoshihito へ）

- hitotose で `latex`（DVI 用）と `dvipng` の実在確認（pdflatex/convert は確認済）。`latex` 不在なら主経路を pdflatex+pdftoppm に切替。
- **team 名の不一致**: 申し送りは「team `ch-dev`」だが、`~/dev/dev-rules/.agmsg-team` は `dev-rules`。実際の協働 team を確定すること（`ch-dev` を新設するのか、`dev-rules` が正なのか）。
