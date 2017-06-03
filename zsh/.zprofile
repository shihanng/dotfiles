typeset -U path

path=(/usr/local/git/bin $path[@])
path=($GOROOT/bin $path[@])
path=($GOPATH/bin $path[@])
path=($HOME/.rbenv/bin $path[@])
path=($PYENV_ROOT/bin $path[@])
path=($HOME/bin $path[@])

for manpath_candidate in \
  /usr/local/man \
  /usr/local/opt/coreutils/libexec/gnuman
do
  if [ -d ${manpath_candidate} ]; then
    export MANPATH=${manpath_candidate}:${MANPATH}
  fi
done
