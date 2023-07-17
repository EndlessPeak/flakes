{ pkgs, ... }:

{
  programs.git = {
    enable = true;
  };

  xdg.configFile."git/config.toml".source = ./config;

}
