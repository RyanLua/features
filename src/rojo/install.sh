#!/bin/sh
set -e

echo "Activating feature 'rojo'"

ROJO_VERSION="${VERSION:-"latest"}"
AFTMAN_VERSION=0.3.0

# Function to run apt-get if needed
apt_get_update_if_needed()
{
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update
    else
        echo "Skipping apt-get update."
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update_if_needed
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Make sure we have a temporary directory
TMPDIR=/home/vscode/tmp
mkdir -p $TMPDIR

# Install Aftman
check_packages wget unzip
wget https://github.com/LPGhatguy/aftman/releases/download/v$AFTMAN_VERSION/aftman-$AFTMAN_VERSION-linux-x86_64.zip --no-check-certificate
unzip aftman-$AFTMAN_VERSION-linux-x86_64.zip -d $TMPDIR
mv $TMPDIR/aftman /usr/local/bin/aftman
aftman self-install

# Install Rojo
aftman trust rojo-rbx/rojo

if [ "${ROJO_VERSION}" = "latest" ]; then
    aftman add --global rojo-rbx/rojo
else
    aftman add --global rojo-rbx/rojo@"$ROJO_VERSION"
fi
