#!/usr/bin/env bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

echo "Activating feature 'rojo'"

ROJO_VERSION=${VERSION:-"latest"}
INSTALL_AFTMAN=${INSTALLAFTMAN:-"true"}
AFTMAN_VERSION="latest"

# Clean up
rm -rf /var/lib/apt/lists/*

# Function to run apt-get if needed
apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Figure out correct version of a three part version number is not passed
find_version_from_git_tags() {
    local variable_name=$1
    local requested_version=${!variable_name}
    if [ "${requested_version}" = "none" ]; then return; fi
    local repository=$2
    local prefix=${3:-"tags/v"}
    local separator=${4:-"."}
    local last_part_optional=${5:-"false"}
    if [ "$(echo "${requested_version}" | grep -o "." | wc -l)" != "2" ]; then
        local escaped_separator=${separator//./\\.}
        local last_part
        if [ "${last_part_optional}" = "true" ]; then
            last_part="(${escaped_separator}[0-9]+)?"
        else
            last_part="${escaped_separator}[0-9]+"
        fi
        local regex="${prefix}\\K[0-9]+${escaped_separator}[0-9]+${last_part}$"
        local version_list="$(git ls-remote --tags ${repository} | grep -oP "${regex}" | tr -d ' ' | tr "${separator}" "." | sort -rV)"
        if [ "${requested_version}" = "latest" ] || [ "${requested_version}" = "current" ] || [ "${requested_version}" = "lts" ]; then
            declare -g ${variable_name}="$(echo "${version_list}" | head -n 1)"
        else
            set +e
            declare -g ${variable_name}="$(echo "${version_list}" | grep -E -m 1 "^${requested_version//./\\.}([\\.\\s]|$)")"
            set -e
        fi
    fi
    if [ -z "${!variable_name}" ] || ! echo "${version_list}" | grep "^${!variable_name//./\\.}$" > /dev/null 2>&1; then
        echo -e "Invalid ${variable_name} value: ${requested_version}\nValid values:\n${version_list}" >&2
        exit 1
    fi
    echo "${variable_name}=${!variable_name}"
}

# Install dependencies
check_packages ca-certificates wget unzip
if ! type git > /dev/null 2>&1; then
    check_packages git
fi

# Use dpkg --print-architecture to find if arch is aarch64 or x86_64
if [ "$(dpkg --print-architecture)" = "aarch64" ]; then
    ARCH="aarch64"
else
    ARCH="x86_64"
fi

# Make sure we have a temporary directory
TMPDIR=/home/vscode/tmp
mkdir -p $TMPDIR

# Install Aftman
if [ "${INSTALL_AFTMAN}" = "true" ]; then
    find_version_from_git_tags AFTMAN_VERSION https://github.com/LPGhatguy/aftman
    aftman_filename="aftman-${AFTMAN_VERSION}-linux-${ARCH}.zip"

    wget https://github.com/LPGhatguy/aftman/releases/download/v${AFTMAN_VERSION}/${aftman_filename}
    unzip ${aftman_filename} -d $TMPDIR
    mv $TMPDIR/aftman /usr/local/bin/aftman
    aftman self-install
fi

# Install Rojo
find_version_from_git_tags ROJO_VERSION https://github.com/rojo-rbx/rojo
rojo_filename="rojo-${ROJO_VERSION}-linux-${ARCH}.zip"

wget https://github.com/rojo-rbx/rojo/releases/download/v${ROJO_VERSION}/${rojo_filename}
unzip ${rojo_filename} -d $TMPDIR
mv $TMPDIR/rojo /usr/local/bin/rojo
