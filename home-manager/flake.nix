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
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Shared packages list (with cowsay added)
      myPackages = with pkgs; [
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
        
        # Nix development tools
        nixpkgs-fmt
        nix-diff
        nix-tree
      ];
      
    in {
      homeConfigurations."z6" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          {
            # ===== .CONFIG DIRECTORIES =====
            xdg.configFile = {
              "i3".source = "${self}/dotfiles/config/i3";
              "kitty".source = "${self}/dotfiles/config/kitty";
              "mpd".source = "${self}/dotfiles/config/mpd";
              "ncmpcpp".source = "${self}/dotfiles/config/ncmpcpp";
              "neofetch".source = "${self}/dotfiles/config/neofetch";
              "nix".source = "${self}/dotfiles/config/nix";
              "nvim".source = "${self}/dotfiles/config/nvim";
              "polybar".source = "${self}/dotfiles/config/polybar";
              "picom".source = "${self}/dotfiles/config/picom";
              "rofi".source = "${self}/dotfiles/config/rofi";
              "qutebrowser".source = "${self}/dotfiles/config/qutebrowser";
            };

            # ===== HOME DOTFILES =====
            home.file = {
              ".tmux.conf".source = "${self}/dotfiles/home/.tmux.conf";
              ".tmux-powerlinerc".source = "${self}/dotfiles/home/.tmux-powerlinerc";
              ".themes/z6.omp.json".source = "${self}/themes/z6.omp.json";
              
              ".tmux".source = "${self}/dotfiles/home/.tmux";
              ".mpd".source = "${self}/dotfiles/home/.mpd";
              ".ncmpcpp".source = "${self}/dotfiles/home/.ncmpcpp";
            };

            # Program configurations
            programs.git = {
              enable = true;
              userName = "z6death";
              userEmail = "tnz426.z6@gmail.com";
            };

            programs.bash = {
              enable = true;
              shellAliases = {
                ll = "ls -la";
                update = "sudo xbps-install -Su";
                hm = "home-manager switch --flake ~/.hacking/home-manager#z6";
              };
            };

            home.stateVersion = "23.11";
            home.packages = myPackages;
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        name = "z6-environment";

        packages = [
          home-manager.packages.${system}.default
          pkgs.nix
          pkgs.nixpkgs-fmt
          pkgs.git
        ] ++ myPackages;  # Also include your packages in dev shell

        shellHook = ''
          echo "✨ Z6's development environment"
          echo "Run: home-manager switch --flake .#z6"
          echo "Cowsay test: $(cowsay 'Hello from Nix!')"
        '';
      };

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
