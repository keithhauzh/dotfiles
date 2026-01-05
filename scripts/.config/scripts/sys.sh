#!/bin/sh
SESSION="sys"
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    tmux new-session -d -s "$SESSION" -n btop btop
    tmux new-window -t "$SESSION" -n wiremix wiremix
fi
tmux attach -t "$SESSION"
