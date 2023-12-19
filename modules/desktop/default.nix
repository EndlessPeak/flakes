{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # NixOS's core configuration for leesin's desktop computer
  # This file aims to build X11 KDE Environment

  # For power management
  # Conflicts with services.tlp
  services = {
    power-profiles-daemon.enable = false;
    upower.enable = true;
  };
 
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # dconf is a low-level configuration system.
  programs.dconf.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  services = {
  # Enable the X11 windowing system.
    xserver = {
      enable = true;

      # Enable the Plasma 5 Desktop Environment.
      displayManager ={
        sddm.enable = true;
        sddm.theme = "${import ./sddm-theme.nix { inherit pkgs;}}";
      };

      desktopManager.plasma5.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };
    # PipeWire is a new low-level multimedia framework.
    # It aims to offer capture and playback for both audio and video with minimal latency.
    # It support for PulseAudio-, JACK-, ALSA- and GStreamer-based applications.
    # PipeWire has a great bluetooth support, it can be a good alternative to PulseAudio.
    # https://nixos.wiki/wiki/PipeWire
    pipewire = {
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
  services = {
    blueman.enable = true;

    # https://flatpak.org/setup/NixOS
    flatpak.enable = true;

    # Proxy
    v2raya.enable = true;

    # sysstat
    sysstat.enable = true;
  };

  # security with polkit
  security.polkit = {
    enable = true;
    extraConfig =
    ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" || action.id == "org.freedesktop.udisks.filesystem-mount-system-internal")  &&
            subject.local && subject.isInGroup("wheel"))
        {
            return polkit.Result.YES;
        }
      });
    '';
  };
  systemd = {
    user.services.plasma-polkit-agent = {
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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

  # XDG
  xdg.portal = {
    enable = true;
    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    # and vscode has open like `External Uri Openers`
    xdgOpenUsePortal = true;
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

  # enable zsh system-wide
  programs.zsh.enable = true;

  imports = [
    ./fonts.nix
    ./input.nix
    ./software.nix
  ];
}
