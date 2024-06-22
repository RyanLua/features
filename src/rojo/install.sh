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
if [ $VERSION == "latest" ]
then
    aftman add --global rojo-rbx/rojo
else
    aftman add --global rojo-rbx/rojo@${VERSION}
fi
aftman trust rojo
aftman install
