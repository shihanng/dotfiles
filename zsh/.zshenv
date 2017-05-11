export GOPATH=$HOME/go
export TERM="xterm-256color"
export EDITOR='nvim'
export VISUAL='nvim'
export LESS='-XRMsIg'
export LANG=C
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_SHELL=zsh

path=(/usr/local/git/bin $path)
path=($GOROOT/bin $path)
path=($GOPATH/bin $path)
path=($PYENV_ROOT/bin $path)
path=($PYENV_ROOT/shims $path)
path=($PYENV_ROOT/plugins/pyenv-virtualenv/shims $path)
path=($HOME/.rbenv/shims $path)
path=($HOME/bin $path)
export PATH

for manpath_candidate in \
  /usr/local/man \
  /usr/local/opt/coreutils/libexec/gnuman
do
  if [ -d ${manpath_candidate} ]; then
    export MANPATH=${manpath_candidate}:${MANPATH}
  fi
done
