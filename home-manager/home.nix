{ config, pkgs, ... }:

{
  # Set these to match your actual system username
  home.username = "z6";
  home.homeDirectory = "/home/z6";
  home.stateVersion = "23.11";
  
  # Basic packages
  home.packages = with pkgs; [
    cowsay
    neofetch
  ];
  
  programs.home-manager.enable = true;
}
