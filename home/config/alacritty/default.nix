{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
  };

  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  xdg.configFile."alacritty/theme_catppuccino.yml".source = ./theme_catppuccino.yml;

}
