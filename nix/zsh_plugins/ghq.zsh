# https://github.com/Songmu/ghq-handbook/blob/master/ja/05-ghq-list.md#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E4%B8%80%E8%A6%A7%E3%83%91%E3%82%B9%E5%8F%96%E5%BE%97%E3%82%92%E3%81%8A%E3%81%93%E3%81%AA%E3%81%86ghq-list
fzf-src () {
    local repo=$(ghq list | fzf --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src
