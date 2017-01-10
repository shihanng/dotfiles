1. apt-get install zsh
2. chsh -s /bin/zsh

1. tmux + git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
2. git
3. stow
4. xclip
5. peco in bin

## Tmux
*  Prefix (`PRE`) is binded to `C-q`.
*  Split pane:
   -  Horizontally: `PRE |`.
   -  Vertically: `PRE -`.
   -  `PRE PRE` cycles to next pane.
*  `PRE a` to toogle panes synchronization.
*  List all available colours:

    ```sh
    for i in {0..255} ; do
      printf "\x1b[38;5;${i}mcolour${i}\n"
    done
    ```
*  C-I: install plugins, C-U: update.

Install pyenv
