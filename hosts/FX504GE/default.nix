{ config, pkgs, lib, ... } @ args:

# leesin's main computer

{
  boot.supportedFilesystems = [
    "ext4"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  # Kernel Version
  # Always use the latest version
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader ={
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      # useOSProber = true;
    };
  };

  # Correctly detect microphone plugged in a 4-pin 3.5mm (TRRS) jack
  # https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture
  boot.extraModprobeConfig = ''
    options snd_hda_intel index=0 model=dell-headset-multi
  '';

  networking = {
    hostName = "endlesspeak";   # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  time.hardwareClockInLocalTime = true;

  # We need to enable unfree packages
  nixpkgs.config = {
    allowUnfree = lib.mkForce true;
    joypixels.acceptLicense = true;
  };

  # import other components
  imports = [
    # hardware scan
    ./hardware-configuration.nix
    ./nvidia.nix

    # NixOS configuration
    ../../modules
    ../../modules/desktop
    ../../modules/user
    ../../modules/editor
    ../../modules/develop
  ];
}
