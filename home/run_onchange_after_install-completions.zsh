#!/bin/zsh
atuin gen-completions --shell zsh --out-dir $HOME/.completions/
kustomize completion zsh > $HOME/.completions/_kustomize
