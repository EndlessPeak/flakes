{ config, lib, pkgs, ... }:

{
  # NixOS's core configuration for leesin's desktop computer
  # This file aims to build X11 KDE Environment

  imports = [
    ./core-server.nix
  ];

  # to install chrome, you need to enable unfree packages
  nixpkgs.config.allowUnfree = lib.mkForce true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;
    fontDir.enable = true;

    fonts = with pkgs; [
      # icon fonts
      # material-design-icons
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

      # LXGW-WenKai
      lxgw-wenkai

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "SauceCodePro"
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

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      # The following shows how to use NUR packages
      config.nur.repos.ruixi-rebirth.fcitx5-pinyin-moegirl
      config.nur.repos.ruixi-rebirth.fcitx5-pinyin-zhwiki
    ];
  };
 

  # dconf is a low-level configuration system.
  programs.dconf.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Polkit
    libsForQt5.polkit-kde-agent

    # Editor
    neovim 
    emacs29

    # Proxy
    v2raya

    # Software
    alsa-lib
    alsa-utils
    firefox
    flameshot

    # Terminal
    alacritty
 
    # Graphics
    xclip
    xorg.xrandr

    # python,I may need to use python with root permission.
    (python310.withPackages (ps: with ps; [
      ipython
      pandas
      requests
      pyquery
      pyyaml
    ]))
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # PipeWire is a new low-level multimedia framework.
  # It aims to offer capture and playback for both audio and video with minimal latency.
  # It support for PulseAudio-, JACK-, ALSA- and GStreamer-based applications. 
  # PipeWire has a great bluetooth support, it can be a good alternative to PulseAudio.
  #     https://nixos.wiki/wiki/PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Remove sound.enable or turn it off if you had it set previously
  # pulseaudio seems cause conflicts with pipewire
  sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;

  # enable bluetooth & gui paring tools - blueman
  # or you can use cli:
  # $ bluetoothctl
  # [bluetooth] # power on
  # [bluetooth] # agent on
  # [bluetooth] # default-agent
  # [bluetooth] # scan on
  # ...put device in pairing mode and wait [hex-address] to appear here...
  # [bluetooth] # pair [hex-address]
  # [bluetooth] # connect [hex-address]
  # Bluetooth devices automatically connect with bluetoothctl as well:
  # [bluetooth] # trust [hex-address]
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;

  # security with polkit
  security.polkit.enable = true;

  services.power-profiles-daemon = {
    enable = true;
  };
  # Following are security with gnome-kering
  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.greetd.enableGnomeKeyring = true;

  # services = {
  #   # dbus.packages = [ pkgs.gcr ];

  #   # geoclue2.enable = true;
  #   udev.enable = true;
  #   udev.packages = with pkgs; [
  #     gnome.gnome-settings-daemon
  #     platformio # udev rules for platformio
  #     android-udev-rules
  #   ];
  # };

  # Proxy
  services.v2raya.enable = true;
  
  # XDG
  xdg.portal = {
    enable = true;
    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    # and vscode has open like `External Uri Openers`
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr # for wlroots based compositors(hyprland/sway)
      xdg-desktop-portal-gtk # for gtk
      xdg-desktop-portal-kde  # for kde
    ];
  };

  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    zsh
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.bash;
}
