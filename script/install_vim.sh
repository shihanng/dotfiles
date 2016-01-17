#!/bin/bash

set -e
set -u

USER=$(who -m | awk '{print $1;}')

apt-get remove -y --purge \
	vim \
	vim-runtime \
	vim-gnome \
	vim-tiny \
	vim-common \
	vim-gui-common

apt-get build-dep -y vim-gnome
 
apt-get install -y \
	liblua5.1-dev \
	luajit \
	libluajit-5.1 \
	python-dev \
	ruby-dev \
	libperl-dev \
	libncurses5-dev \
	libgnome2-dev \
	libgnomeui-dev \
	libgtk2.0-dev \
	libatk1.0-dev \
	libbonoboui2-dev \
	libcairo2-dev \
	libx11-dev \
	libxpm-dev \
	libxt-dev

rm -rf /usr/local/share/vim
rm -f /usr/bin/vim

LUA_I="/usr/include/lua5.1/include"
if [ ! -d ${LUA_I} ]; then
	mkdir ${LUA_I}
fi
ln -sf /usr/include/lua5.1/*.h "${LUA_I}"

git clone https://github.com/vim/vim --depth 1
pushd vim
make distclean
./configure --with-features=huge \
	--enable-rubyinterp \
	--enable-largefile \
	--disable-netbeans \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib/python2.7/config \
	--enable-perlinterp \
	--enable-luainterp \
	--with-luajit \
	--enable-gui=auto \
	--enable-fail-if-missing \
	--with-lua-prefix=/usr/include/lua5.1 \
	--enable-cscope 
make 
make install

popd

rm -rf vim

su - $USER -c "mkdir -p $HOME/.vim/"
su - $USER -c "git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim"
su - $USER -c "mkdir $HOME/.vim/.backup $HOME/.vim/.swp $HOME/.vim/.undo"
exit 0
