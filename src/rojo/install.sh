#!/bin/sh
set -e

echo "Activating feature 'rojo'"

# Make sure we have a temporary directory
TMPDIR=/home/vscode/tmp
mkdir -p $TMPDIR

# Install Aftman
AFTMAN_VERSION=0.3.0

wget https://github.com/LPGhatguy/aftman/releases/download/v$AFTMAN_VERSION/aftman-$AFTMAN_VERSION-linux-x86_64.zip
unzip aftman-$AFTMAN_VERSION-linux-x86_64.zip -d $TMPDIR
mv $TMPDIR/aftman /usr/local/bin/aftman

# Install Rojo
if [ "${ROJO_VERSION:-latest}" = "latest" ]
then
    aftman add --global rojo-rbx/rojo
else
    aftman add --global rojo-rbx/rojo@"${ROJO_VERSION}"
fi
aftman trust rojo-rbx/rojo
aftman install