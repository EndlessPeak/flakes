{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      # Noto for no tofu
      # Noto Sans/Serif CJK SC/TC/HK/JP/KR
      noto-fonts # No Chinese
      noto-fonts-cjk # Chinese
      noto-fonts-emoji
      noto-fonts-extra

      # Adobe SiYuan
      source-sans # No Chinese. Including `Source Sans 3` `Source Sans Pro` `Source Sans 3 VF`
      source-serif # No Chinese.
      source-code-pro #Source Code Pro
      source-han-sans # Chinese HeiTi
      source-han-serif # Chinese Song

      # Other Fonts
      lxgw-wenkai
      liberation_ttf
      arkpandora_ttf

      # Font
      # keep reporting license issue,must add license in nixpkgs
      joypixels

      # Code and Symbol
      symbola
      cascadia-code

      # Chinese
      wqy_zenhei
      wqy_microhei

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "SourceCodePro"
          "Iosevka"
        ];
      })

      #(pkgs.callPackage ../../fonts/icomoon-feather-icon-font.nix { })

      # arch linux icon, used temporarily in waybar
      #(pkgs.callPackage ../../fonts/archcraft-icon-font.nix { })

    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
