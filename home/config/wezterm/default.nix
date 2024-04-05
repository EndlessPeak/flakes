{ pkgs, ... }:

{
#   programs.alacritty = {
#     enable = true;
#   };

  xdg.configFile."wezterm/wezterm.lua".source = ./wezterm.lua;

}
