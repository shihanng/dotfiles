.PHONY: all dotfiles clean

all: dotfiles

targets := git zsh config nvim vim

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)
