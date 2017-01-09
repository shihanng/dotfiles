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
  zgen load mollifier/anyframe
  zgen load tevren/gitfast-zsh-plugin

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

zstyle ":anyframe:selector:" use peco
zstyle ":anyframe:selector:peco:" command 'peco --layout=bottom-up'
bindkey '^r' anyframe-widget-put-history
bindkey '^o' anyframe-widget-cdr
bindkey '^b' anyframe-widget-checkout-git-branch

if which peco &> /dev/null; then
  function peco-snippets() {
    local tac
    if which gtac &> /dev/null; then
        tac="gtac"
    elif which tac &> /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(grep -v "^#" $HOME/.snippets | eval $tac | \
                peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
  }
  zle -N peco-snippets
  bindkey '^s' peco-snippets
fi
