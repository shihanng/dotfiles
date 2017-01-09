.PHONY: all dotfiles clean

all: dotfiles

dotfiles:
	stow git zsh

clean:
	stow -D git zsh
