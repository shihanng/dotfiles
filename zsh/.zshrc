# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

function must_source() {
  if [ -f $1 ]; then
      source $1
  else
      (>&2 echo "must_source: ${1} not found")
  fi
}

must_source "${HOME}/.zshrc.local"

# mollifier/anyframe
fpath=($HOME/src/anyframe(N-/) $fpath)
autoload -Uz anyframe-init
anyframe-init
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

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

# Custom go test
gotest () {
    go test "${@}" | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/''
}

path=(/usr/local/git/bin $path)
path=($GOROOT/bin $path)
path=($GOPATH/bin $path)
path=($HOME/bin $path)
path=($HOME/.pyenv/bin $path)
path=($HOME/.rbenv/bin $path)
export PATH

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"

eval "$(direnv hook zsh)"
alias tmux='direnv exec / tmux'

# For pet.
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^s' pet-select
