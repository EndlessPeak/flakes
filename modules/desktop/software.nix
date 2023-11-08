{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      # Polkit
      libsForQt5.polkit-kde-agent

      # Editor
      kate

      # Utils
      flameshot

      # Chat
      telegram-desktop

      # Graphics & Graphical Utils
      xclip
      xdg-utils
      xorg.xrandr

      # RDP
      libsForQt5.krdc

      # Disk
      libsForQt5.filelight

      # Nix Utils
      nix-prefetch-git

      # SDDM Theme Dependencies
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      # python,I may need to use python with root permission.
      #(python310.withPackages (ps: with ps; [
      #  ipython
      #  pandas
      #  requests
      #  pyquery
      #  pyyaml
      #]))

      # config.nur.repos.xddxdd.qqmusic
      # nur.repos.xddxdd.qqmusic
    ])++
    (with pkgs-unstable;[

    ]);
}
