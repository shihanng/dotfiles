#!/usr/bin/env bash

script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd "$script_dir"
base_dir=$(git rev-parse --show-toplevel)

ln -sf "${base_dir}/gitconfig" $HOME/.gitconfig
ln -sf "${base_dir}/tmux/tmux.conf" $HOME/.tmux.conf
ln -sf "${base_dir}/vim/vimrc" $HOME/.vimrc
ln -sf "${base_dir}/zsh/zshrc" $HOME/.zshrc

cp -f "${base_dir}/gitconfig.local" $HOME/.gitconfig.local

