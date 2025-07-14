#!/bin/bash

# onCreate.sh - Sets up PATH for Rojo toolchain managers after container creation
# This script runs after the container is created and the user environment is available

set -e

echo "Setting up Rojo toolchain PATH configuration..."

# Debug output
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "Warning: _REMOTE_USER and _REMOTE_USER_HOME not set, using defaults"
    _REMOTE_USER="vscode"
    _REMOTE_USER_HOME="/home/vscode"
fi

# Function to add PATH to user's shell profiles
add_to_user_profile() {
    local user_home="$1"
    local path_entry="$2"
    
    if [ -d "$user_home" ]; then
        # Add to .bashrc if it exists or create it
        if [ -f "$user_home/.bashrc" ] || [ ! -f "$user_home/.zshrc" ]; then
            echo "Adding $path_entry to $user_home/.bashrc"
            echo "export PATH=\"$path_entry:\$PATH\"" >> "$user_home/.bashrc"
        fi
        
        # Add to .zshrc if it exists
        if [ -f "$user_home/.zshrc" ]; then
            echo "Adding $path_entry to $user_home/.zshrc"
            echo "export PATH=\"$path_entry:\$PATH\"" >> "$user_home/.zshrc"
        fi
        
        # Also add to .profile as a fallback
        echo "export PATH=\"$path_entry:\$PATH\"" >> "$user_home/.profile"
    fi
}

# Set up PATH for all supported toolchain managers
echo "Setting up PATH for rokit"
add_to_user_profile "$_REMOTE_USER_HOME" "\$HOME/.rokit/bin"

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

echo "Setting up PATH for aftman"
add_to_user_profile "$_REMOTE_USER_HOME" "\$HOME/.aftman/bin"

# Try to create global profile entry (requires sudo/root)
if command -v sudo >/dev/null 2>&1 && sudo test -w /etc/profile.d 2>/dev/null; then
    echo 'export PATH="$HOME/.aftman/bin:$PATH"' | sudo tee /etc/profile.d/aftman.sh > /dev/null
    sudo chmod +x /etc/profile.d/aftman.sh
    echo "Created global profile entry for aftman"
elif [ -w /etc/profile.d ] 2>/dev/null; then
    echo 'export PATH="$HOME/.aftman/bin:$PATH"' > /etc/profile.d/aftman.sh
    chmod +x /etc/profile.d/aftman.sh
    echo "Created global profile entry for aftman"
else
    echo "Skipping global profile entry for aftman (no permission)"
fi

echo "Rojo toolchain PATH setup finished"
