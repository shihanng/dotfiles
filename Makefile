.PHONY: all dotfiles clean

all: dotfiles

targets := git zsh config

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)
