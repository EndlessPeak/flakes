{ config, lib, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Extract Tools
    zip
    xz
    unzip
    p7zip

    # Broswer
    # firefox
    google-chrome

    # Chat
    telegram-desktop

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

    # Picture Capture
    flameshot

    # Python
    # I may need to use python with root permission.
    # (python3.withPackages (ps: with ps; [
    #   numpy
    #   pandas
    #   ipython
    #   requests
    #   pyquery
    #   pyyaml
    # ]))

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
    
    # Terminal
    alacritty
    wezterm

    tmux

    # Version Control
    git # used by nix flakes

    # Proxy
    v2raya
    
    # RDP
    # libsForQt5.krdc

    # Polkit
    libsForQt5.polkit-kde-agent

    # Disk
    libsForQt5.filelight

    # SDDM Theme Dependencies
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects

    # KDE Apperence
    lightly-qt

    # Video
    vlc
    obs-studio
    ffmpeg

    # Others
    qq
    nur.repos.xddxdd.qqmusic

    # SFTP
    filezilla

    # blog
    hugo
    pandoc
  ];
}
