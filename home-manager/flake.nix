{
  description = "Z6's reproducible environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # Complete package list
      allPackages = with pkgs; [
        # Basic utilities
        bat curl fzf git tmux wget cowsay
        
        # System tools
        acpi autoconf automake btop cmake cryptsetup
        dnsmasq du-dust gcc gdb jq light lvm2 gnumake
        mdadm meson ninja nmap pkg-config rsync smartmontools
        xclip xdotool xz
        
        # Networking
        aircrack-ng avahi bluez bridge-utils networkmanager
        networkmanagerapplet wirelesstools
        
        # Development
        cargo clang clinfo go python3 rustc
        
        # GUI programs
        feh flameshot gimp i3 kitty lxappearance pavucontrol 
        picom polybar rofi viewnior vlc xarchiver
        
        # Audio
        bluez-alsa cava mpc mpd ncmpcpp pulseaudio
        
        # Other
        autojump chrony dialog figlet jp2a jmtpfs john
        nnn preload qutebrowser ranger redshift squashfsTools
        syslinux termshark tlp upower vimb virt-manager
        xorriso zathura p7zip csfml opencl-headers
        gitAndTools.git-filter-repo git-lfs hcxdumptool mtools neofetch
        
        # Nix tools
        nixpkgs-fmt nix-diff nix-tree
      ];

      # Safe file copying function
      safeCopy = ''
        echo "📁 Copying config files..."
        
        # Copy config directories if they exist
        if [ -d "${self}/dotfiles/config" ]; then
          mkdir -p ~/.config
          for dir in "${self}"/dotfiles/config/*; do
            if [ -d "$dir" ]; then
              dir_name=$(basename "$dir")
              echo "  Copying ~/.config/$dir_name/"
              cp -r "$dir" ~/.config/ 2>/dev/null || true
            fi
          done
        fi
        
        # Copy home dotfiles if they exist
        if [ -d "${self}/dotfiles/home" ]; then
          for file in "${self}"/dotfiles/home/.*; do
            if [ -f "$file" ]; then
              file_name=$(basename "$file")
              echo "  Copying ~/$file_name"
              cp "$file" ~/ 2>/dev/null || true
            fi
          done
        fi
        
        # Copy themes if they exist
        if [ -d "${self}/themes" ]; then
          mkdir -p ~/.themes
          echo "  Copying ~/.themes/"
          cp -r "${self}"/themes/* ~/.themes/ 2>/dev/null || true
        fi
        
        echo "✅ Config files copied!"
      '';

    in {
      # Development shell with ALL packages
      devShells.${system}.default = pkgs.mkShell {
        name = "z6-environment";
        
        packages = allPackages;

        shellHook = ''
          echo "🚀 Z6's complete environment activated!"
          echo "All ${toString (builtins.length allPackages)} packages available"
          echo ""
          echo "Your config files are available at:"
          echo "  Configs: ${self}/dotfiles/config/"
          echo "  Dotfiles: ${self}/dotfiles/home/"
          echo "  Themes: ${self}/themes/"
          echo ""
          echo "To copy configs to your home directory, run:"
          echo "  copy-configs"
          echo ""
          cowsay "Ready to hack!"
          
          # Add helper command
          copy-configs() {
            ${safeCopy}
          }
        '';
      };

      # Package with all programs
      packages.${system}.default = pkgs.buildEnv {
        name = "z6-complete";
        paths = allPackages;
      };

      # App to install packages and configs
      apps.${system}.default = {
        type = "app";
        program = toString (pkgs.writeShellScript "z6-install" ''
          # Install packages
          echo "📦 Installing all packages..."
          nix profile install .#
          
          # Copy config files
          ${safeCopy}
          
          echo "✅ Installation complete!"
        '');
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
