#!/bin/bash

# onCreate.sh - Sets up PATH for Rojo toolchain managers after container creation
# This script runs after the container is created and the user environment is available

set -e

echo "Setting up Rojo toolchain PATH configuration..."

# Set up PATH for all supported toolchain managers
echo "Setting up PATH for rokit"

# Try to create global profile entry (requires sudo/root)
if command -v sudo >/dev/null 2>&1 && sudo test -w /etc/profile.d 2>/dev/null; then
    echo 'export PATH="$HOME/.rokit/bin:$PATH"' | sudo tee /etc/profile.d/rokit.sh > /dev/null
    sudo chmod +x /etc/profile.d/rokit.sh
    echo "Created global profile entry for rokit"
elif [ -w /etc/profile.d ] 2>/dev/null; then
    echo 'export PATH="$HOME/.rokit/bin:$PATH"' > /etc/profile.d/rokit.sh
    chmod +x /etc/profile.d/rokit.sh
    echo "Created global profile entry for rokit"
else
    echo "Skipping global profile entry for rokit (no permission)"
fi

echo "Rojo toolchain PATH setup finished"
