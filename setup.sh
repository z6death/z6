#!/bin/bash

# Install Nix in single-user mode
echo "Installing Nix package manager (single-user mode)..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon --yes

# Source Nix environment (exactly what the installer says to do for single-user)
echo "Sourcing Nix environment..."
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

# Add Nix sourcing to .bashrc
echo "Adding Nix to .bashrc..."
if ! grep -q "nix.sh" ~/.bashrc; then
    echo '' >> ~/.bashrc
    echo '# Nix package manager (single-user)' >> ~/.bashrc
    echo 'if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi' >> ~/.bashrc
fi

# Install Home Manager
echo "Setting up Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Source .bashrc to apply changes in current session
echo "Sourcing .bashrc to apply changes..."
source ~/.bashrc

echo "Installation complete! Nix and Home Manager are now ready to use."
