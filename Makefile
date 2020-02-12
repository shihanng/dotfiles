.PHONY: all dotfiles clean

all: dotfiles

targets := home

dotfiles:
	stow $(targets)

clean:
	stow -D $(targets)

ansible-local:
	$(MAKE) -C ansible local
