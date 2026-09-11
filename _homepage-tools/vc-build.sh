#!/bin/bash
# vChewing 首頁：只在獨立目錄建置檢查用（絕不碰 /tmp/vcsite，那是預覽伺服器的來源）
set -eu
export GEM_HOME="$HOME/.gem/ruby/2.6.0"
export PATH="$GEM_HOME/bin:$PATH"
TH=/Users/shikisuen/Repos/_vChewing/_OtherRepos/homepage-jekyll-theme-read-the-docs
SRC=/Users/shikisuen/Repos/_vChewing/_MainWorkspace/vChewing-HomePage.io
WORK=/tmp/vcsite-check
OUT=/tmp/vcsite_out

rm -rf "$WORK" "$OUT" && mkdir -p "$WORK"
rsync -a --exclude '.git' --exclude '_site' "$SRC/" "$WORK/"
# 同名檔案以站台為準（與正式站的 theme 覆蓋語意一致）。
for d in _layouts _includes _sass assets; do
  [ -d "$TH/$d" ] && rsync -a --ignore-existing --exclude 'node_modules' "$TH/$d/" "$WORK/$d/"
done
python3 - <<'PY'
import glob, re
for p in glob.glob("/tmp/vcsite-check/**/*.liquid", recursive=True):
    t = open(p, encoding="utf-8").read()
    if "github_edit_link" in t:
        open(p, "w", encoding="utf-8").write(re.sub(r"[ \t]*\{%-?\s*github_edit_link[^%]*%\}\n?", "", t))
PY
cat >> "$WORK/_config.yml" <<'YAML'

plugins:
  - jekyll-default-layout
  - jekyll-readme-index
  - jekyll-relative-links
  - jekyll-optional-front-matter
  - jekyll-titles-from-headings
YAML
cd "$WORK" && jekyll build --destination "$OUT" 2>&1 | grep -v 'world writable' | tail -3
