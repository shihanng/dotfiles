#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd "$script_dir"
base_dir=$(git rev-parse --show-toplevel)

ln -sf "${base_dir}/vim/vimrc" $HOME/.vimrc
ln -sf "${base_dir}/zsh/zshrc" $HOME/.zshrc
ln -sf "${base_dir}/nvim/init.vim" $HOME/.config/nvim/init.vim
ln -sf "${base_dir}/i3" $HOME/.i3

