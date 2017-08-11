- `ansible-playbook -l "arch" provision.yml --ask-become-pass`
- For setting gnome-terminal color theme
  - https://github.com/Mayccoll/Gogh
  - http://askubuntu.com/questions/631481/gnome-terminal-profiles-are-not-being-loaded

```
pyenv install -s {{ py2ver }}
pyenv install -s {{ py3ver }}
pyenv uninstall -f neovim2
pyenv uninstall -f neovim3
pyenv virtualenv -f {{ py2ver }} neovim2
pyenv virtualenv -f {{ py3ver }} neovim3
pyenv activate neovim2
pip install neovim
pyenv activate neovim3
pip install neovim flake8
ln -s `pyenv which flake8` /home/{{ user }}/bin/flake8
```
