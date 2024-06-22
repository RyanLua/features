#!/bin/sh
set -e

echo "Activating feature 'rojo'"

# Install Aftman
AFTMAN_VERSION=0.3.0

wget https://github.com/LPGhatguy/aftman/releases/download/v$AFTMAN_VERSION/aftman-$AFTMAN_VERSION-linux-x86_64.zip
unzip aftman-$AFTMAN_VERSION-linux-x86_64.zip
./aftman self-install
. ~/.profile

# Install Rojo
if [[ -z "${VERSION}" ]]; then
ROJO_VERSION="latest"
else
ROJO_VERSION="${VERSION}"
fi

if [ $ROJO_VERSION == "latest" ]
then
    aftman add --global rojo-rbx/rojo
else
    aftman add --global rojo-rbx/rojo@${ROJO_VERSION}
fi
aftman trust rojo
aftman install
