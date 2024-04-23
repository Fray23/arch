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
PS1="[\w]\n-> "

export VISUAL=nvim
export EDITOR="$VISUAL"

set -o vi
bind '"jk":"\e"'
alias dc='docker compose'
alias en='source ../../env/bin/activate'
alias end='source env/bin/activate'
alias db='docker compose exec backend bash'
alias v='nvim'
alias s='exa -al --color=always --group-directories-first'
alias tw="if ! tmux has-session -t work 2>/dev/null; then tmux new-session -s work; else tmux attach-session -t work; fi"
alias some="if ! tmux has-session -t some 2>/dev/null; then tmux new-session -s some; else tmux attach-session -t some; fi"
alias fm="pcmanfm &"
alias tl='tmux ls'
alias moc='mocp -T tty'
alias ff3='/home/fs/Desktop/a79/env/bin/python3 /home/fs/Desktop/a79/ff3.py'
alias bg='feh --bg-fil'
alias em='emacsclient -t'
alias wifi='/home/fs/bin/wifi.py'
alias bgg='/home/fs/bin/gifwall.sh'

