{ config, lib, pkgs, ... }:

{
  imports = [
    ./config
  ];

  home.username = "xahlee";
  home.homeDirectory = "/home/xahlee";

  xresources.properties = {
    "Xcursor.size" = 14;
    #"Xft.dpi" = 172;
  };

  # programs.zsh.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;

}
