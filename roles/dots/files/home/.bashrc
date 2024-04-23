#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

echo ""
# PS1="[\w] ($(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \n-> "
PS1='[\w]$(git rev-parse --is-inside-work-tree &>/dev/null && echo " ($(git branch 2>/dev/null | grep '\''^\*'\'' | colrm 1 2))") \n-> '

export VISUAL=nvim
export EDITOR="$VISUAL"

function tmux_create_session_with_FZF() {
  # tmux new session
  DIR=$(find /home/fs/Desktop/work -maxdepth 2 -type d ! -readable -prune -o -print | fzf)

  if [ -z "$DIR" ]; then
    return
  fi

  DIR_NAME=$(basename "$DIR")
  CURRENT_DIR=$(echo "${DIR}" | awk -F'/' '{print $(NF-1)}')

  SESSION_NAME="${CURRENT_DIR}/${DIR_NAME}"

  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -s "$SESSION_NAME" -c "$DIR"
  else
    tmux attach-session -t "$SESSION_NAME"
  fi
}

function tmux_attach_session_FZF() {
    # tmux open exist session
    SESSION_NAME=$(tmux ls | awk '{print $1}' | sed s/:// | fzf)
    if [ -z "$SESSION_NAME" ]; then
        return
    fi

    tmux attach-session -t "$SESSION_NAME"
}

function cd_with_FZF() {
    cd $(find /home/fs/Desktop/work -maxdepth 2 -type d ! -readable -prune -o -print | fzf)
}

function git_checkout_FZF() {
    BRANCH_FZF_OUTPUT="$(git branch | fzf)"
    BRANCH_NAME="$(echo "$BRANCH_FZF_OUTPUT" | sed 's/ //g')"

    git checkout "$BRANCH_NAME"
}

function git_pull() {
    BRANCH_NAME="$(git branch | grep "*" | sed s/*// | sed s/\ //)"
    git pull origin "$BRANCH_NAME"
}

function git_push_FZF() {
    BRANCH_FZF_OUTPUT="$(git branch | fzf)"
    if [[ ! $BRANCH_FZF_OUTPUT = 'staging' ]]; then
        echo "no"
    elif [[ ! $BRANCH_FZF_OUTPUT = 'main' ]]; then
        echo "no"
    elif [[ ! $BRANCH_FZF_OUTPUT = 'master' ]]; then
        echo "no"
    else
        git push origin "$BRANCH_NAME"
    fi
}


set -o vi
bind '"jk":"\e"'

# main
alias v='nvim'
alias s='exa -al --color=always --group-directories-first'
alias c='clear'

# pyenv
alias en='source ../../env/bin/activate'
alias end='source env/bin/activate'

# docker
alias dc='docker compose'
alias db='docker compose exec backend bash'
alias ds='docker compose exec backend sh'
alias dn='docker compose exec neovim sh'

# tmux
alias tw="if ! tmux has-session -t work 2>/dev/null; then tmux new-session -s work; else tmux attach-session -t work; fi"
alias some="if ! tmux has-session -t some 2>/dev/null; then tmux new-session -s some; else tmux attach-session -t some; fi"
alias tn="tmux new-session -s"
alias tl='tmux ls'
alias tf=tmux_create_session_with_FZF
alias ta=tmux_attach_session_FZF
alias f=cd_with_FZF

# daily features
alias fm="pcmanfm &"
alias moc='mocp -T tty'
alias ff3='/home/fs/Desktop/a79/env/bin/python3 /home/fs/Desktop/a79/ff3.py'
alias bg='feh --bg-fil'
alias em='emacsclient -t'
alias wifi='/home/fs/bin/wifi.py'
alias bgg='/home/fs/bin/gifwall.sh'

# git
alias gdel='f() { git branch -D $(git branch | grep "$1"); }; f'
alias gbl='git branch'
alias gnew='git checkout -b $1'
alias gs='git status'

alias gc=git_checkout_FZF
alias gpu=git_pull
alias gpp=git_push_FZF

alias gsl='git stash list'
alias gss='git stash save'
alias gsp='git stash pop'

# ============ CHEAT SHEET ============
# Forward Tunnel: map port from remote machine/network on local machine
# ssh -L $LOCAL_PORT:$REMOTE_IP:$REMOTE_PORT $USER@$SERVER

# Reverse Tunnel: make local port accessable to remote machine
# ssh -R $REMOTE_PORT:$LOCAL_IP:$LOCAL_PORT $USER@$SERVER
#
