
```
ssh-copy-id -i <path-to-public-key> <user>@<ip>
```

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
