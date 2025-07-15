#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'rojo' Feature with no options.
#
# IMPORTANT: This feature requires Ubuntu 22.04+ due to GLIBC compatibility with Rokit.
# The default ubuntu:focal (20.04) will cause test failures.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# Eg:
# {
#    "image": "mcr.microsoft.com/devcontainers/base:ubuntu-22.04",
#    "features": {
#      "rojo": {}
#    },
#    "remoteUser": "root"
# }
#
# Thus, the value of all options will fall back to the default value in 
# the Feature's 'devcontainer-feature.json'.
# For the 'rojo' feature, that means the default version is 'latest'.
#
# These scripts are run as 'root' by default. Although that can be changed
# with the '--remote-user' flag.
# 
# This test can be run with the following command:
#
#    devcontainer features test \ 
#                   --features rojo   \
#                   --remote-user root \
#                   --skip-scenarios   \
#                   --base-image mcr.microsoft.com/devcontainers/base:ubuntu-22.04 \
#                   /path/to/this/repo

set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib. Syntax is...
# check <LABEL> <cmd> [args...]
check "rokit version" rokit --version
check "rojo version" rojo --version
check "rokit can install wally" rokit init && rokit add --force UpliftGames/wally && wally --version
check "rokit can install wally global" rokit add --global --force UpliftGames/wally && wally --version
check "rokit can lune-org/lune lune global" rokit add --global --force lune-org/lune && lune --version

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
