
```
ssh-copy-id -i <path-to-public-key> <user>@<ip>
```

For macOS, install [Homebrew](https://brew.sh/).

Depending on

```
git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur
```

We also need a `vault` file 

```
ansible-vault create group_vars/all/vault
```

with the following  content of the vault

```
---
pet_gitlab_access_token:
pet_gitlab_id:
user_email:
user_fullname:
user_name:
user_pass:
```

Run

```
ansible-playbook --diff -vv provision.yml -i hosts --limit <ip-address> --private-key=~/.ssh/id_rsa --ask-vault-pass
ansible-playbook --diff --check -vv provision.yml -i hosts --limit localhost --ask-vault-pass
```

Adding passphrase to [ssh key](https://help.github.com/en/articles/working-with-ssh-key-passphrases#adding-or-changing-a-passphrase).
Then add the [SSH key in to GitHub](https://help.github.com/en/enterprise/2.15/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent).

Run `run_keybase` on Linux machine.

Import the GPG key using [this guide](https://github.com/pstadler/keybase-gpg-github) and the key in `$HOME/gitconfig.local`.

Run `ibus-setup` on Linux machine.
