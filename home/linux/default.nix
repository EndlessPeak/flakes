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

  programs.git = {
    enable = true;
    userName = "EndlessPeak";
    userEmail = "endlesspeak@163.com";
  };

  home.packages = with pkgs;[
    neofetch
    zip
    xz
    unzip
    p7zip

    ripgrep
    fzf

    cowsay

    hugo
    btop

  ];

  programs.alacritty = {
    enable = true;
  };

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
