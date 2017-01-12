export GOPATH=$HOME/go

for path_candidate in \
  $HOME/bin \
  $GOPATH/bin \
  $HOME/.pyenv/bin \
  /usr/local/bin \
  /usr/local/git/bin \
  /usr/local/go/bin \
  /usr/local/texlive/2016/bin/"$(uname -m)-$(uname | tr '[:upper:]' '[:lower:]')" \
  /bin \
  /usr/bin \
  /usr/sbin \
  /sbin \
  /opt/X11/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${path_candidate}:${PATH}
  fi
done

for manpath_candidate in \
  /usr/local/man \
  /usr/local/opt/coreutils/libexec/gnuman
do
  if [ -d ${manpath_candidate} ]; then
    export MANPATH=${manpath_candidate}:${MANPATH}
  fi
done

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
