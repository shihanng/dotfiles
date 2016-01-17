#!/bin/bash

set -e
set -u

USER=$(who -m | awk '{print $1;}')

apt-get install -y zsh

chsh -s $(which zsh) $USER

sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

exit 0
