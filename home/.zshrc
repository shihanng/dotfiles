# https://github.com/zplug/zplug/wiki/Configurations#examples
# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update
fi

# Essential
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "lukechilds/zsh-better-npm-completion", defer:2
zplug "mollifier/anyframe"
zplug "willghatch/zsh-cdr"
zplug "knqyf263/pet", use:misc/completions/zsh
zplug "~/zsh-plugins", as:plugin, use:"*.zsh", from:local, defer:1
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load

typeset -U path

export TERM="xterm-256color"
export EDITOR='vim'
export VISUAL='vim'
export LESS='-XRMsIg'
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

path=($HOME/go/bin $path[@])
path=($HOME/.fzf/bin $path[@])

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(pyenv init -)"
eval "$(rbenv init -)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion
eval "$(direnv hook zsh)"
source <(kubectl completion zsh)
