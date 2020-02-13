.PHONY: local

local:
	ansible-playbook --diff -vv provision.yml -i hosts --limit localhost --ask-vault-pass
