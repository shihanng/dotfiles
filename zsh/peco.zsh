zstyle ":anyframe:selector:" use peco
zstyle ":anyframe:selector:peco:" command 'peco --layout=bottom-up'
bindkey '^r' anyframe-widget-execute-history
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
