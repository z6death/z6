{
  description = "Z6's complete Nix environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "x86_64-linux";
      # Configure nixpkgs to allow unfree packages
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Shared packages list
      myPackages = with pkgs; [
        # Basic utilities
        cowsay bat curl fzf git tmux wget
        
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
        feh flameshot gimp i3 i3blocks i3lock-color i3status
        kitty lxappearance pavucontrol picom polybar rofi
        viewnior vlc xarchiver
        
        # Audio
        bluez-alsa cava mpc mpd ncmpcpp pulseaudio
        
        # Other
        autojump chrony dialog figlet jp2a jmtpfs john
        nnn preload qutebrowser ranger redshift squashfsTools
        syslinux termshark tlp upower vimb virt-manager
        xorriso zathura p7zip csfml opencl-headers 
        gitAndTools.git-filter-repo git-lfs hcxdumptool mtools neofetch
        
        # Nix development tools
        nixpkgs-fmt
        nix-diff
        nix-tree
      ];
      
    in {
      # Home Manager configuration
      homeConfigurations."z6" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix 
          {
            home.packages = myPackages;
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      # Development shell
      devShells.${system}.default = pkgs.mkShell {
        name = "z6-environment";

        packages = [
          home-manager.packages.${system}.default
          pkgs.nix
          pkgs.nixpkgs-fmt
          pkgs.nixd
          pkgs.git
        ] ++ myPackages;

        shellHook = ''
          echo "✨ Z6's reproducible environment"
          echo "All programs are managed by Nix for perfect reproducibility"
          echo ""
          echo "Run 'home-manager switch --flake .#z6' to apply configuration"
          echo ""
        '';
      };

      # Packages
      packages.${system} = {
        z6-packages = pkgs.buildEnv {
          name = "z6-packages";
          paths = myPackages;
        };
      };

      defaultPackage.${system} = self.packages.${system}.z6-packages;
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
