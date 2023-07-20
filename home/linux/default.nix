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
    # Extract Tools
    zip
    xz
    unzip
    p7zip

    # Search Utils
    fd # replace for find
    ripgrep # replace for grep
    fzf # fzf has a dependency on fd

    # TUI utils
    exa # replace for ls
    bat # replace for cat
    tldr # replace for man page,too long don't read
    zoxide # replace for cd
    delta # replace for diff
    
    # TUI Programs
    lolcat
    cowsay
    neofetch
    gitui

    # TUI Monitor
    joshuto
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
