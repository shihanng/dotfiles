
```
ssh-copy-id -i <path-to-public-key> <user>@<ip>
```

```
ansible-playbook --diff -vv provision.yml -i '<ip>,' --user=<user> --private-key=<path-to-private-key> -K
```
