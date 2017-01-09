.PHONY: all dotfiles clean

all: dotfiles

targets := git zsh peco

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)
