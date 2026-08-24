#!/usr/bin/env bash
# Start (or attach to) the "money-matrix" tmux development session.
#
# Windows:
#   1 Git       ~/kd/money-matrix — plain shell
#   2 Codex     ~/kd/money-matrix — Codex
#   3 Backend   ~/kd/money-matrix — Go API on port 6060
#   4 Frontend  ~/kd/money-matrix — Vite on port 4040

set -euo pipefail

SESSION="money-matrix"
PROJECT="$HOME/kd/money-matrix"

attach() {
  if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION"
  else
    tmux attach-session -t "$SESSION"
  fi
}

if tmux has-session -t "$SESSION" 2>/dev/null; then
  attach
  exit 0
fi

command -v tmux >/dev/null 2>&1 || {
  echo "tmux is required." >&2
  exit 1
}

command -v mise >/dev/null 2>&1 || {
  echo "mise is required." >&2
  exit 1
}

if [ ! -d "$PROJECT" ]; then
  echo "Money Matrix repository not found at $PROJECT" >&2
  exit 1
fi

if [ ! -f "$PROJECT/.env" ] || [ ! -d "$PROJECT/frontend/node_modules" ]; then
  echo "Money Matrix is not bootstrapped. Run this first:" >&2
  echo "  cd '$PROJECT' && mise run bootstrap" >&2
  exit 1
fi

(
  cd "$PROJECT"
  mise run db:start
  mise run doctor
)

run() {
  local window="$1"
  shift
  tmux send-keys -t "$window" "$*" C-m
}

win_git=$(tmux new-session -d -s "$SESSION" -n "Git" -c "$PROJECT" -P -F '#{window_id}')

win=$(tmux new-window -t "$SESSION" -n "Codex" -c "$PROJECT" -P -F '#{window_id}')
run "$win" 'codex'

win=$(tmux new-window -t "$SESSION" -n "Backend" -c "$PROJECT" -P -F '#{window_id}')
run "$win" 'mise run backend'

win=$(tmux new-window -t "$SESSION" -n "Frontend" -c "$PROJECT" -P -F '#{window_id}')
run "$win" 'mise run frontend'

tmux select-window -t "$win_git"
attach
