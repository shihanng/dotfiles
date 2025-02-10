#!/bin/zsh
atuin gen-completions --shell zsh --out-dir $HOME/.completions/
kind completion zsh > $HOME/.completions/_kind
kustomize completion zsh > $HOME/.completions/_kustomize
