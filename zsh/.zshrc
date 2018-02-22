#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh


typeset -U path

export TERM="xterm-256color"
export EDITOR='nvim'
export VISUAL='nvim'
export LESS='-XRMsIg'
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

path=($HOME/bin $path[@])
path=($HOME/go/bin $path[@])
for manpath_candidate in \
  /usr/local/man \
  /usr/local/opt/coreutils/libexec/gnuman
do
  if [ -d ${manpath_candidate} ]; then
    export MANPATH=${manpath_candidate}:${MANPATH}
  fi
done


#
# vi-mode.
#
zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# 'v' to edit the command line
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey '^P' up-history
bindkey '^N' down-history
export KEYTIMEOUT=1


#
# tex
#
platform="$(uname -m)-$(tr '[A-Z]' '[a-z]' <<< `uname -s`)"
path=($HOME/texbin/2017/bin/$platform $path[@])


#
# fzf
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='..'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--sort 20000"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


#
# mollifier/anyframe
#
fpath=($HOME/bin/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf --extended --tiebreak=index'
bindkey '^r' anyframe-widget-put-history
bindkey '^o' anyframe-widget-cdr
bindkey '^b' anyframe-widget-checkout-git-branch


#
# direnv
#
eval "$(direnv hook zsh)"
alias tmux='direnv exec / tmux'


#
# pet.
#
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


#
# pyenv
#
export PYENV_ROOT="$HOME/.pyenv"
path=($PYENV_ROOT/bin $path[@])
source $(pyenv root)/completions/pyenv.zsh
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


#
# rbenv
#
path=($HOME/.rbenv/bin $path[@])
eval "$(rbenv init -)"


#
# qq
#
export TMPDIR="/tmp"
alias qq="$(echo "$GOPATH" | cut -d : -f 1)/src/github.com/y0ssar1an/q/q.sh"
alias rmqq="rm $TMPDIR/q"


#
# nvm
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# hub
#
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit
eval "$(hub alias -s)"


#
# kubectl
#
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
