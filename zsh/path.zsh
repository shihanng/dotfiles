export GOPATH=$HOME/go

for path_candidate in /usr/bin \
  /bin \
  /usr/sbin \
  /sbin \
  /opt/X11/bin \
  /usr/local/bin \
  /usr/local/texlive/2016/bin/"$(uname -m)-$(uname | tr '[:upper:]' '[:lower:]')" \
  /usr/local/opt/coreutils/libexec/gnubin \
  /usr/local/git/bin \
  /usr/local/go/bin \
  $GOPATH/bin \
  $HOME/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH=${path_candidate}:${PATH}
  fi
done

for manpath_candidate in /usr/local/man \
  /usr/local/opt/coreutils/libexec/gnuman
do
  if [ -d ${manpath_candidate} ]; then
    export MANPATH=${manpath_candidate}:${MANPATH}
  fi
done
