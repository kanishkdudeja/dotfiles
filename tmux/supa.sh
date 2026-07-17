#!/usr/bin/env bash
# Start (or attach to) the "supa" tmux dev session.
#
# Windows:
#   1 Git        ~/supabase/infrastructure — plain shell for git
#   2 Codex      ~/supabase/infrastructure — update + launch codex
#   3 Claude     ~/supabase/infrastructure — update + launch claude
#   4 Platform   ~/supabase/infrastructure — git pull, then mise platform
#   5 Studio     ~/supabase/infrastructure — pull ~/supabase/supabase, then mise studio:dev
#   6 Credits UI ~/supabase/credit-system-admin-ui — git pull only
#
# Commands are injected with send-keys, so every window starts immediately
# and runs in parallel — nothing blocks the session coming up.

set -euo pipefail

SESSION="supa"
INFRA="$HOME/supabase/infrastructure"
SUPABASE_REPO="$HOME/supabase/supabase"
CREDITS_UI="$HOME/supabase/credit-system-admin-ui"

# Attach or switch depending on whether we're already inside tmux.
attach() {
  if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$SESSION"
  else
    tmux attach-session -t "$SESSION"
  fi
}

# If the session already exists, just jump to it.
if tmux has-session -t "$SESSION" 2>/dev/null; then
  attach
  exit 0
fi

# run <window-id> <command...> — type a command into a window without waiting on it.
run() {
  local win="$1"
  shift
  tmux send-keys -t "$win" "$*" C-m
}

# 1: Git — plain shell, nothing running.
win_git=$(tmux new-session -d -s "$SESSION" -n "Git" -c "$INFRA" -P -F '#{window_id}')

# 2: Codex — update the CLI, then launch it.
win=$(tmux new-window -t "$SESSION" -n "Codex" -c "$INFRA" -P -F '#{window_id}')
run "$win" 'npm i -g @openai/codex && codex'

# 3: Claude — update the CLI, then launch it.
win=$(tmux new-window -t "$SESSION" -n "Claude" -c "$INFRA" -P -F '#{window_id}')
run "$win" 'claude update && claude'

# 4: Platform — pull current branch, then start the platform stack.
win=$(tmux new-window -t "$SESSION" -n "Platform" -c "$INFRA" -P -F '#{window_id}')
run "$win" 'git pull && mise platform'

# 5: Studio — pull the supabase monorepo's current branch, then start studio
#    (window stays in the infrastructure directory).
win=$(tmux new-window -t "$SESSION" -n "Studio" -c "$INFRA" -P -F '#{window_id}')
run "$win" "git -C '$SUPABASE_REPO' pull && STUDIO_FRAMEWORK=tanstack mise studio:dev"

# 6: Credits UI — pull only; server gets started manually when needed.
win=$(tmux new-window -t "$SESSION" -n "Credits UI" -c "$CREDITS_UI" -P -F '#{window_id}')
run "$win" 'git pull'

tmux select-window -t "$win_git"
attach
