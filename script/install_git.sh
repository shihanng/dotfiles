#!/bin/bash

set -e
set -u

GIT_VERSION="2.7.0"
GIT_TAR="v${GIT_VERSION}.tar.gz"

apt-get update
apt-get install -y \
		libcurl4-gnutls-dev \
		libexpat1-dev \
		gettext \
		libz-dev \
		libssl-dev \
		asciidoc \
		xmlto \
		docbook2x \
		autoconf

wget https://github.com/git/git/archive/${GIT_TAR}
tar -zxf ${GIT_TAR}

pushd "git-${GIT_VERSION}"
make configure
./configure --prefix=/usr
make all doc info
sudo make install \
	install-doc \
	install-html \
	install-info
popd

rm -rf ${GIT_TAR}
rm -rf "git-${GIT_VERSION}"

apt-get install -y gitg

exit 0
