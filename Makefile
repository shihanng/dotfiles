.PHONY: all dotfiles clean

all: dotfiles

targets := git zsh config nvim

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)
