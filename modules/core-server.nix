{ lib, pkgs, ... }:

{
  # NixOS's core configuration for all of my machines

  # for nix server, we do not need to keep too much generations
  #boot.loader.grub.conLimit = lib.mkDefault 10;
  boot.loader.grub.configurationLimit =lib.mkDefault 3;
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 1w";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # trusted users
  nix.settings.trusted-users = ["leesin"];

  # Allow unfree packages,it will be enable in desktop.nix
  nixpkgs.config.allowUnfree = lib.mkDefault false;

  # Set time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_CTYPE = "zh_CN.UTF-8";
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
    "zh_TW.UTF-8/UTF-8"
    "zh_HK.UTF-8/UTF-8"
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;

  # Disable the OpenSSH daemon.
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     X11Forwarding = true;
  #     PermitRootLogin = "no"; # disable root login
  #     PasswordAuthentication = false; # disable password login
  #   };
  #   openFirewall = true;
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git # used by nix flakes

    # Basic
    linuxHeaders
    linux-firmware

    # Editor
    vim

    # Locales
    glibcLocales

    # Utils
    wget
    curl
    tree
    
    # System tools
    sysstat
    pciutils
    usbutils
    
    # Shell
    zsh  

    # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
    (
      let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [ pkgs.pkg-config ];
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
  ];

  # replace default editor with emacs
  environment.variables.EDITOR = "emacs";

  # virtualisation.docker = {
  #   enable = true;
  # };

}
