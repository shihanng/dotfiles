#!/bin/bash

set -e
set -u

USER=$(who -m | awk '{print $1;}')

apt-get install -y \
	software-properties-common \
	python-dev \
	python-pip \
	python3-dev \
	python3-pip

add-apt-repository -y ppa:neovim-ppa/unstable

apt-get update
apt-get install -y neovim curl ctags
pip2 install neovim

su $USER <<EOF
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
EOF

apt-get install -y cmake

NVIM_PLUG_DIR="$HOME/.config/nvim/plugged"
YCM_DIR="${NVIM_PLUG_DIR}/YouCompleteMe"

su $USER <<EOF
if [ ! -d ${NVIM_PLUG_DIR} ]; then
        mkdir -p ${NVIM_PLUG_DIR}
fi
pushd ${NVIM_PLUG_DIR}
git clone https://github.com/Valloric/YouCompleteMe.git
pushd ${YCM_DIR}
git submodule update --init --recursive
popd
popd

pushd $HOME
mkdir ycm_build
pushd ycm_build
cmake -G "Unix Makefiles" . "${YCM_DIR}/third_party/ycmd/cpp"
cmake --build . --target ycm_support_libs --config Release
popd
popd
EOF

su $USER <<EOF
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
pushd "${YCM_DIR}/third_party/ycmd/third_party/gocode"
go build
popd
EOF

su $USER <<EOF
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

go get -u github.com/jstemmer/gotags
EOF

exit 0
