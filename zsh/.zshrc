function must_source() {
	if [ -f $1 ]; then
	    source $1
	else
	    (>&2 echo "must_source: ${1} not found")
	fi
}

# load zgen
must_source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
  zgen load git/contrib/completion/git-completion.zsh

  # Generate the init script from plugins above
  zgen save
fi

for path_candidate in \
  $HOME/bin \
  $GOPATH/bin \
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
