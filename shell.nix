{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  packages = with pkgs; [   # Basic utilities
    cowsay
    oh-my-posh
    bat
    curl
    fzf
    git
    tmux
    wget
    
    # System tools
    acpi
    autoconf
    automake
    btop
    cmake
    cryptsetup
    dnsmasq
    du-dust
    gcc
    gdb
    jq
    light
    lvm2
    gnumake
    mdadm
    meson
    ninja
    nmap
    pkg-config
    rsync
    smartmontools
    # thefuck removed - no longer available in nixpkgs
    xclip
    xdotool
    xz
    
    # Networking
    aircrack-ng
    avahi
    bluez
    bridge-utils
    networkmanager
    networkmanagerapplet
    wirelesstools
    
    # Development
    cargo
    clang
    clinfo
    go
    python3
    rustc
    
    # Graphics & GUI
    arc-theme
    feh
    flameshot
    font-awesome
    gimp
    i3
    i3blocks
    i3lock-color
    i3status
    kitty
    lxappearance
    papirus-icon-theme
    pavucontrol
    picom
    polybar
    rofi
    viewnior
    vlc
    xarchiver
    xorg.xorgserver
    xwinwrap
    
    # Audio
    bluez-alsa
    cava
    mpc
    mpd
    ncmpcpp
    pulseaudio
    
    # Games & emulation
    cbonsai
    cmatrix
    gnuchess
    lutris
    qemu
    stockfish
    vbam
    vde2
    wine
    winetricks
    
    # Other
    autojump
    chrony
    dialog
    figlet
    jp2a
    jmtpfs
    john
    nnn
    preload
    qutebrowser
    ranger
    redshift
    squashfsTools
    syslinux
    termshark
    tlp
    upower
    vimb
    virt-manager
    xorriso
    zathura

    # Additional packages from your list
    p7zip
    csfml
    opencl-headers
    gitAndTools.git-filter-repo
    git-lfs
    hcxdumptool
    jmtpfs
    mtools
    neofetch
  ];
in

pkgs.mkShell {
  buildInputs = packages;

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
    echo "Shell with ${toString (builtins.length packages)} packages loaded!"
    echo "Unfree packages enabled"
  '';
}
