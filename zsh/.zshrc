# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# mollifier/anyframe
fpath=($HOME/bin/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ":anyframe:selector:" use peco
zstyle ":anyframe:selector:peco:" command 'peco --layout=bottom-up'
bindkey '^r' anyframe-widget-put-history
bindkey '^o' anyframe-widget-cdr
bindkey '^b' anyframe-widget-checkout-git-branch

source $(pyenv root)/completions/pyenv.zsh

eval "$(direnv hook zsh)"
alias tmux='direnv exec / tmux'

# For pet.
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

# Simple vi-mode.
zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# 'v' to edit the command line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey '^P' up-history
bindkey '^N' down-history
export KEYTIMEOUT=1


eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"

export TMPDIR="/tmp"
alias qq="$(echo "$GOPATH" | cut -d : -f 1)/src/github.com/y0ssar1an/q/q.sh"
alias rmqq="rm $TMPDIR/q"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function insert_files() {
    vifm -f < /dev/tty > /dev/tty

    while read l; do
        LBUFFER+="${(qqq)l} "
    done < ~/.config/vifm/vimfiles

    zle reset-prompt
}
zle -N insert_files
bindkey '^t' insert_files

# For hub
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit
eval "$(hub alias -s)"
