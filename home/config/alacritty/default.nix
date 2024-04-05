{ pkgs, ... }:

{
#   programs.alacritty = {
#     enable = true;
#   };

  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
  xdg.configFile."alacritty/theme_catppuccino.toml".source = ./theme_catppuccino.toml;

}
