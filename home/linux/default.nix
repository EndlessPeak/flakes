{ config, pkgs, ... }:

{
  imports = [
    ../config
  ];

  home.username = "leesin";
  home.homeDirectory = "/home/leesin";

  xresources.properties = {
    "Xcursor.size" = 13;
    #"Xft.dpi" = 172;
  };

  # programs.git = {
  #   enable = true;
  #   userName = "EndlessPeak";
  #   userEmail = "endlesspeak@163.com";
  #   defaultBranch = "main";
  # };

  home.packages = with pkgs;[
    # Extract Files
    zip
    xz
    unzip
    p7zip

    # Search Utils
    ripgrep
    fzf

    # TUI Programs
    cowsay
    neofetch
    gitui

    # TUI Monitor
    btop
    htop
    
    # Other Programs
    hugo
  ];

  # programs.alacritty = {
  #   enable = true;
  # };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
