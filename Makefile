.PHONY: all dotfiles clean

all: dotfiles

targets := home

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)
