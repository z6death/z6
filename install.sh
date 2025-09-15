#!/bin/bash

$ sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

sudo xbps-install -Syv $(cat packages.txt | xargs)

sudo ln -s /etc/sv/NetworkManager/ /var/service
sudo ln -s /etc/sv/dbus/ /var/service
sudo ln -s /etc/sv/avahi-daemon/ /var/service
sudo ln -s /etc/sv/lightdm/ /var/service

cd ~/system_z6/
cp * ~/
source ~/.bashrc
