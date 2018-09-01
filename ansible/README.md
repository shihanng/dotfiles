
```
ssh-copy-id -i <path-to-public-key> <user>@<ip>
```

Depending on

```
git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur
```


Run

```
ansible-vault create passwd.yml
ansible-playbook --diff -vv provision.yml -i hosts --limit <ip-address> --private-key=~/.ssh/id_rsa --ask-vault-pass --extra-vars '@passwd.yml'
```

The content of the vault:

```
user_fullname:
user_name:
user_email:
sudo_pass:
```
