.PHONY: all dotfiles clean

all: dotfiles

dotfiles:
	stow git

clean:
	stow -D git
