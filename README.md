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

FOR NEOVIM
pyenv install 2.7.11
pyenv install 3.4.4

pyenv virtualenv 2.7.11 neovim2
pyenv virtualenv 3.4.4 neovim3

pyenv activate neovim2
pip install neovim
pyenv which python  # Note the path

pyenv activate neovim3
pip install neovim
pyenv which python  # Note the path

# The following is optional, and the neovim3 env is still active
# This allows flake8 to be available to linter plugins regardless
# of what env is currently active.  Repeat this pattern for other
# packages that provide cli programs that are used in Neovim.
pip install flake8
ln -s `pyenv which flake8` ~/bin/flake8  # Assumes that $HOME/bin is in $PATH

let g:python_host_prog = '/full/path/to/neovim2/bin/python'
let g:python3_host_prog = '/full/path/to/neovim3/bin/python'
