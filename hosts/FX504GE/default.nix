{ config, ... } @ args:

# leesin's main computer

{
  imports = [
    # hardware scan
    ./hardware-configuration.nix

    # add arch linux boot entry
    ./boot-arch.nix

    # NixOS configuration
    ../../modules/core-desktop.nix
    ../../modules/user-group.nix
  ];
  boot.supportedFilesystems = [
    "ext4"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  boot.loader ={
    efi = {
      canTouchEfiVariables = false;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      # useOSProber = true;
    };
  };

  networking = {
    hostName = "leesin";   # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Nvidia GPU
  # services.xserver.videoDrivers = [ "nvidia" ]; # will install nvidia-vaapi-driver by default
  # hardware.nvidia = {
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   nvidiaSettings = true;
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  # };
 
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
  system.stateVersion = "23.05"; # Did you read the comment?

  time.hardwareClockInLocalTime = true;

}
