#!/bin/bash

set -e
set -u

TMUX_VERSION="2.1"
TMUX_DIR="tmux-${TMUX_VERSION}"
TMUX_TAR="${TMUX_DIR}.tar.gz"
TMUX_DLLINK="https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_TAR}"

apt-get build-dep -y tmux

wget "${TMUX_DLLINK}"
tar -zxf "${TMUX_TAR}"

pushd "${TMUX_DIR}"
./configure
make
make install
popd

rm -rf ${TMUX_DIR}
rm -rf ${TMUX_TAR}

exit 0
