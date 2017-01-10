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

  zgen oh-my-zsh
  zgen oh-my-zsh plugins/gitfast

  # Generate the init script from plugins above
  zgen save
fi

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
