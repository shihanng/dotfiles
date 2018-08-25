
```
ssh-copy-id -i <path-to-public-key> <user>@<ip>
```

Depending on

```
git clone https://github.com/kewlfft/ansible-aur.git ~/.ansible/plugins/modules/aur
```


Run

```
ansible-playbook --diff -vv provision.yml -i '<ip>,' --user=<user> --private-key=<path-to-private-key> -K
```
