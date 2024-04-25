{ config, pkgs, lib, ... } @ args:

{
  boot = {
    supportedFilesystems = [
      "ext4"
      "ntfs"
      "fat"
      "vfat"
      "exfat"
    ];

    # Kernel Version
    # Always use the latest version
    kernelPackages = pkgs.linuxPackages;

    kernelParams = [ 
      "nouveau.modeset=0" 
    ];

    kernelModules = [ 
      "kvm-intel" 
      # "ch341" 
    ];

    loader ={
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
}
