{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Your packages
  home.packages = with pkgs; [
    # Basic utilities
    bat curl fzf git tmux wget
    
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
    syslinux termshark tlp tumbler upower vimb virt-manager
    xorriso zathura p7zip csfml opencl-headers thunar
    gitAndTools.git-filter-repo git-lfs hcxdumptool mtools neofetch
  ];

  # ===== .CONFIG DIRECTORIES =====
  xdg.configFile = {
    "i3".source = ./dotfiles/config/i3;
    "kitty".source = ./dotfiles/config/kitty;
    "mpd".source = ./dotfiles/config/mpd;
    "ncmpcpp".source = ./dotfiles/config/ncmpcpp;
    "neofetch".source = ./dotfiles/config/neofetch;
    "nix".source = ./dotfiles/config/nix;
    "nvim".source = ./dotfiles/config/nvim;
    "polybar".source = ./dotfiles/config/polybar;
    "picom".source = ./dotfiles/config/picom;
    "rofi".source = ./dotfiles/config/rofi;
    "qutebrowser".source = ./dotfiles/config/qutebrowser;
  };

  # ===== HOME DOTFILES =====
  home.file = {
    ".tmux.conf".source = ./dotfiles/home/.tmux.conf;
    ".tmux-powerlinerc".source = ./dotfiles/home/.tmux-powerlinerc;
    ".themes/z6.omp.json".source = ./dotfiles/themes/z6.omp.json;
    
    ".tmux".source = ./dotfiles/home/.tmux;
    ".mpd".source = ./dotfiles/home/.mpd;
    ".ncmpcpp".source = ./dotfiles/home/.ncmpcpp;
  };

  # Program configurations
  programs.git = {
    enable = true;
    userName = "z6";
    userEmail = "z6@example.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo xbps-install -Su";
      hm = "cd ~/.hacking/home-manager && home-manager switch";
    };
  };

  home.stateVersion = "23.11";
}
