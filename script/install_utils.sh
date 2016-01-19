#!/bin/bash

set -e
set -u
set -x

USER=$(who -m | awk '{print $1;}')
UBUNTU_VERSION="$(lsb_release -cs)"

pip install awscli

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
DOCKER_SOURCE="deb https://apt.dockerproject.org/repo ubuntu-${UBUNTU_VERSION} main"
echo "${DOCKER_SOURCE}" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge -y lxc-docker
apt-get install -y linux-image-extra-$(uname -r)
apt-get install -y docker-engine

curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

DOCKER_SERVICE="docker"
if (( $(ps -ef | grep -v grep | grep $DOCKER_SERVICE | wc -l) > 0 )); then
	sudo service $DOCKER_SERVICE stop
fi

sudo service $DOCKER_SERVICE start
usermod -aG docker ${USER}
sudo restart $DOCKER_SERVICE

su $USER <<EOF 
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

go get github.com/peco/peco/cmd/peco
EOF

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
git clone https://github.com/direnv/direnv
pushd direnv
make install
popd
rm -rf direnv

su $USER <<EOF 
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

go get -u github.com/odeke-em/drive/cmd/drive
EOF

exit 0
