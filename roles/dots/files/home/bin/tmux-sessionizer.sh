#!/usr/bin/env bash

function fzf_project() {
  # tmux new session
  DIR=$(find /home/fs/Desktop/work -maxdepth 2 -type d ! -readable -prune -o -print | fzf)

  if [ -z "$DIR" ]; then
    return
  fi

  DIR_NAME=$(basename "$DIR")
  CURRENT_DIR=$(echo "${DIR}" | awk -F'/' '{print $(NF-1)}')

  SESSION_NAME="${CURRENT_DIR}/${DIR_NAME}"

  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -ds "$SESSION_NAME" -c "$DIR"
  fi
  tmux switch-client -t "$SESSION_NAME"
}

function fzf_session() {
    # tmux open exist session
    SESSION_NAME=$(tmux ls | awk '{print $1}' | sed s/:// | fzf)
    if [ -z "$SESSION_NAME" ]; then
        return
    fi

    tmux switch-client -t "$SESSION_NAME"
}

if [[ "$1" == "-E" ]]; then
    fzf_session
else
    fzf_project
fi
