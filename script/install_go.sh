#!/bin/bash

set -e
set -u

VERSION="1.5.3"
OS="linux"
ARCH="amd64"

URL="https://storage.googleapis.com/golang/go${VERSION}.${OS}-${ARCH}.tar.gz"
echo ${URL}
wget ${URL}
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz

rm -rf go$VERSION.$OS-$ARCH.tar.gz

exit 0
