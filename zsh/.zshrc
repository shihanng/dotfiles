# load zgen
source "${HOME}/.zplug/init.zsh"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "dracula/zsh", as:theme
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# ================================= My settings ================================

typeset -U path

# export TERM="xterm-256color"
export TERM=screen-256color-bce 
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
# tex
#
platform="$(uname -m)-$(tr '[A-Z]' '[a-z]' <<< `uname -s`)"
path=($HOME/texbin/2017/bin/$platform $path[@])

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
# eval "$(rbenv init -)"


#
# nvm
#
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#
# fzf
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

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
  BUFFER=" $(pet search --query "$LBUFFER")"
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select


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


#
# kraken
#
kraken () {
	/Applications/GitKraken.app/Contents/MacOS/GitKraken -p $(pwd)
}

# time zsh -ic exit
