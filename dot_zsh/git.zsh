# Ref: https://github.com/petitviolet/dotfiles/blob/99e67dafebfdd073952126dd9e159778fcbf3b12/_zshrc.alias#L346
# select branch
function select_from_git_branch() {
  # local list=$(git branch --sort=refname --sort=-authordate --color --all  --format='%(color:red)%(authordate:short)%(color:reset) %(objectname:short) %(align:width=45,position=left)%(color:green)%(refname:short)%(color:reset)%(end) <%(align:20,left)%(authorname)%(end)>[%(subject)] %(if)%(HEAD)%(then)* %(else)%(end)'; \
  local list=$(\
    git branch --sort=refname --sort=-committerdate --color \
      --format='%(color:red)%(authordate:short)%(color:reset) %(objectname:short) %(color:green)%(refname:short)%(color:reset) %(if)%(HEAD)%(then)* %(else)%(end)'; \
    git tag --color -l \
      --format='%(color:red)%(creatordate:short)%(color:reset) %(objectname:short) %(color:yellow)%(align:width=45,position=left)%(refname:short)%(color:reset)%(end)')

  echo $list | fzf --ansi --preview-window=down:wrap --preview 'f() {
      set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}");
      [ $# -eq 0 ] || git --no-pager log --oneline -100 --pretty=format:"%C(red)%ad%Creset %C(green)%h%Creset %C(blue)%<(15,trunc)%an%Creset: %s" --date=short --color $1;
    }; f {}' |\
    sed -e 's/\* //g' | \
    awk '{print $3}'  | \
    sed -e "s;remotes/;;g" | \
    perl -pe 's/\n/ /g'
}

# select branch to checkout
function select_git_checkout() {
    local SELECTED_FILE_TO_CHECKOUT=`select_from_git_branch | sed -e "s;origin/;;g"`
    if [ -n "$SELECTED_FILE_TO_CHECKOUT" ]; then
      BUFFER="git checkout $(echo "$SELECTED_FILE_TO_CHECKOUT" | tr '\n' ' ')"
      CURSOR=$#BUFFER
    fi
    zle accept-line
}
zle -N select_git_checkout
bindkey "^b" select_git_checkout
