{ config, pkgs, ... }:

{
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
    userName = "z6death";
    userEmail = "tnz426.z6@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo xbps-install -Su";
      hm = "cd ~/.hacking/home-manager && home-manager switch --flake .#z6";
    };
  };

  home.stateVersion = "23.11";
}
