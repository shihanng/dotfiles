.PHONY: local

local:
	ansible-playbook --diff --check -vv provision.yml -i hosts --limit localhost --ask-vault-pass
