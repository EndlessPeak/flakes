{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    (with pkgs; [
      # Broswer
      firefox
      google-chrome

      # Chat
      telegram-desktop

      # Disk
      libsForQt5.filelight

      # Editor
      vim
      kate
      neovim

      # Graphics & Graphical Utils
      xclip
      xdg-utils
      xorg.xrandr

      # Locales
      glibcLocales

      # Linux Basic
      linuxHeaders
      linux-firmware

      # Nix Utils
      nix-prefetch-git

      # Polkit
      libsForQt5.polkit-kde-agent

      # Picture Capture
      flameshot

      # Python
      # I may need to use python with root permission.
      (python3.withPackages (ps: with ps; [
         numpy
         pandas
      #  ipython
      #  requests
      #  pyquery
      #  pyyaml
      ]))

      # RDP
      libsForQt5.krdc

      # System Utils
      curl
      tree
      wget
      killall
      alsa-lib
      alsa-utils

      # System tools
      sysstat
      pciutils
      usbutils
      
      # SDDM Theme Dependencies
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      # Terminal
      alacritty

      tmux

      # Version Control
      git # used by nix flakes

    ])++
    (with pkgs-unstable;[
      # Proxy
      v2raya
    ]);
}
