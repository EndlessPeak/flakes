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

  home.packages = with pkgs;[
    # Extract Files
    zip
    xz
    unzip
    p7zip

    # Search Utils
    fd
    ripgrep
    fzf

    # TUI Programs
    lolcat
    cowsay
    neofetch
    gitui

    # TUI Monitor
    lf # inspired by ranger
    btop
    htop
    
    # KDE Programs
    latte-dock
    lightly-qt

    # Others
    vlc
    obs-studio
    hugo
  ];

  # programs.zsh.enable = true;

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
