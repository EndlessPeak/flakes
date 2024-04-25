{ config, pkgs, lib, ... }:

{
  # NixOS's core configuration for all of my machines

  # for nix server, we do not need to keep too much generations
  # boot.loader.grub.conLimit = lib.mkDefault 10;
  boot.loader.grub.configurationLimit = lib.mkDefault 5;
  
  nix = {
    # Do garbage collection weekly to keep disk usage low
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 3d";
    };

    settings = {
      # Manual optimise storage: nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;

      # enable flakes globally
      experimental-features = [ "nix-command" "flakes" ];

      # trusted users
      trusted-users = ["xahlee"];

      # Protect nix-shell against garbage collection
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  # Allow unfree packages,it will be enable in system.nix
  # nixpkgs.config.allowUnfree = lib.mkDefault true;

  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
      "zh_HK.UTF-8/UTF-8"
    ];
  };

  imports = [
    ./networking.nix
    ./system.nix
  ];
}
