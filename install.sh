#!/usr/bin/env bash
# Install or check the frontend toolkit for Claude Code. Safe to run repeatedly.
#   ./install.sh [--stack essentials|design-first|solo|full]   (default: full)
#   ./install.sh --check
set -euo pipefail

PLAYWRIGHT_MCP=0.0.84
CONTEXT7_MCP=4.5.0
DEVTOOLS_MCP=1.12.0
TS_SERVER=6.0.3
TYPESCRIPT=6.0.3  # TypeScript 7 ships no tsserver, which the language server needs

ROOT=$(cd -- "$(dirname -- "$0")" && pwd)
OFFICIAL=claude-plugins-official
CHROME="$HOME/.local/bin/chromium-pw"
LINK="$HOME/.claude/skills/frontend"

plugin() {  # plugin <name@marketplace> [enabled|disabled]
  claude plugin install -s user "$1" >/dev/null 2>&1 || true
  if [ "${2:-enabled}" = enabled ]; then
    claude plugin enable -s user "$1" >/dev/null 2>&1 || true
  else
    claude plugin disable -s user "$1" >/dev/null 2>&1 || true
  fi
}

mcp() {  # mcp <name> <command...>
  local name=$1; shift
  claude mcp remove -s user "$name" >/dev/null 2>&1 || true
  claude mcp add -s user "$name" -- "$@" >/dev/null
}

essentials() {
  mkdir -p "$(dirname "$LINK")" "$HOME/.local/bin"
  ln -sfn "$ROOT/skills/frontend" "$LINK"

  claude plugin marketplace add pbakaus/impeccable >/dev/null 2>&1 || true
  plugin impeccable@impeccable
  plugin "frontend-design@$OFFICIAL"
  local engine
  engine=$(find "$HOME/.claude/plugins/cache/impeccable" -type f -path '*/scripts/impeccable' | sort -V | tail -1)
  [ -n "$engine" ] && sh "$engine" telemetry off >/dev/null

  mcp context7 npx -y "@upstash/context7-mcp@$CONTEXT7_MCP"
  npx -y "@playwright/mcp@$PLAYWRIGHT_MCP" install-browser chrome-for-testing >/dev/null 2>&1
  mcp playwright npx -y "@playwright/mcp@$PLAYWRIGHT_MCP" --headless --browser chromium --isolated
  ln -sf "$(find "$HOME/.cache/ms-playwright" -type f -path '*chrome-linux64/chrome' | sort -V | tail -1)" "$CHROME"
}

typescript_lsp() {
  npm i -g --prefix "$HOME/.local" "typescript-language-server@$TS_SERVER" "typescript@$TYPESCRIPT" >/dev/null
  plugin "typescript-lsp@$OFFICIAL"
}

check() {
  local bad=0
  say() { if [ "$2" = 0 ]; then echo "ok    $1"; else echo "MISS  $1"; bad=1; fi; }
  has() { command -v "$1" >/dev/null; echo $?; }
  say "node" "$(has node)"
  say "typescript-language-server" "$(has typescript-language-server)"
  [ -f "$(npm root -g --prefix "$HOME/.local")/typescript/lib/tsserver.js" ]; say "tsserver for the language server" $?
  [ -f "$LINK/SKILL.md" ]; say "frontend skill linked" $?
  [ -x "$CHROME" ]; say "browser for MCP servers" $?
  local plugins servers
  plugins=$(claude plugin list 2>&1)
  servers=$(claude mcp list 2>&1)
  for p in impeccable frontend-design typescript-lsp; do
    grep -A3 "❯ $p@" <<<"$plugins" | grep -q enabled; say "plugin $p" $?
  done
  for s in context7 playwright chrome-devtools; do
    grep -q "^$s:.*Connected" <<<"$servers"; say "mcp $s" $?
  done
  python3 "$ROOT/scripts/audit.py" "$ROOT/skills/frontend/library" >/dev/null; say "library audit" $?
  python3 "$ROOT/tests/test_tokens.py" >/dev/null; say "token contrast" $?
  return $bad
}

command -v claude >/dev/null || { echo "Claude Code is required" >&2; exit 1; }
case "${1:-}" in
  --check) check; exit ;;
  --stack) stack=${2:?stack name required} ;;
  "") stack=full ;;
  *) sed -n 2,4p "$0" >&2; exit 2 ;;
esac
command -v npx >/dev/null || { echo "Node.js is required; see README.md" >&2; exit 1; }

cd "$HOME"
case "$stack" in
  essentials) essentials ;;
  design-first) essentials; typescript_lsp; plugin "figma@$OFFICIAL" ;;
  solo)
    essentials
    claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill >/dev/null 2>&1 || true
    plugin ui-ux-pro-max@ui-ux-pro-max-skill
    ;;
  full)
    essentials; typescript_lsp
    mcp chrome-devtools npx -y "chrome-devtools-mcp@$DEVTOOLS_MCP" --headless --isolated \
      --no-usage-statistics --no-performance-crux --executablePath "$CHROME"
    plugin "figma@$OFFICIAL" disabled
    plugin "vercel@$OFFICIAL" disabled
    ;;
  *) echo "unknown stack: $stack" >&2; exit 2 ;;
esac
echo "Stack '$stack' installed. Restart Claude Code, then run ./install.sh --check"
