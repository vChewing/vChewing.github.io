#!/bin/bash
# vChewing 首頁：本機預覽
#
# 用「站台 repo ＋ 本地 theme（含尚未推上去的改動）＋ GitHub Pages 同版外掛」
# 現地建置並起 Jekyll 伺服器；改站台的 markdown／SCSS 會自動重建。
# 改 *theme repo* 之後要重跑本腳本（theme 是複製進 /tmp/vcsite 的）。
#
# 用法：  bash /tmp/vc-preview.sh [port]     預設 4399
set -e

export GEM_HOME="$HOME/.gem/ruby/2.6.0"
export PATH="$GEM_HOME/bin:$PATH"

TH=/Users/shikisuen/Repos/_vChewing/_OtherRepos/homepage-jekyll-theme-read-the-docs
SRC=/Users/shikisuen/Repos/_vChewing/_MainWorkspace/vChewing-HomePage.io
PORT="${1:-4399}"
WORK=/tmp/vcsite

echo "→ 同步站台內容…"
mkdir -p "$WORK"
# 原地同步（--delete 但不砍目錄）：萬一伺服器正在跑，watcher 才不會斷。
rsync -a --delete --exclude '.git' --exclude '_site' "$SRC/" "$WORK/"

echo "→ 疊上本地 theme…"
# 同名檔案以站台為準（與正式站的 theme 覆蓋語意一致）。
for d in _layouts _includes _sass assets; do
  [ -d "$TH/$d" ] && rsync -a --ignore-existing --exclude 'node_modules' "$TH/$d/" "$WORK/$d/"
done

# theme 的 breadcrumbs 用到 GitHub Pages 專屬標籤 {% github_edit_link %}，
# 本機沒裝 jekyll-github-metadata，先把它去掉（只動 /tmp 的副本）。
python3 - <<'PY'
import glob, re
for p in glob.glob("/tmp/vcsite/**/*.liquid", recursive=True):
    t = open(p, encoding="utf-8").read()
    if "github_edit_link" in t:
        open(p, "w", encoding="utf-8").write(re.sub(r"[ \t]*\{%-?\s*github_edit_link[^%]*%\}\n?", "", t))
PY

echo "→ 補上 GitHub Pages 預設外掛…"
if ! grep -q '^plugins:' "$WORK/_config.yml"; then
  cat >> "$WORK/_config.yml" <<'YAML'

plugins:
  - jekyll-default-layout
  - jekyll-readme-index
  - jekyll-relative-links
  - jekyll-optional-front-matter
  - jekyll-titles-from-headings
YAML
fi

echo
echo "→ http://127.0.0.1:$PORT/    （Ctrl-C 停止）"
echo
cd "$WORK" && exec jekyll serve --port "$PORT" --host 127.0.0.1
