{ config, lib, pkgs, ... }:

{
  # virtualisation configuration
  virtualisation = {
  #  vmware.host = {
  #    enable = true;
  #    package = pkgs.vmware-workstation;
  #    extraConfig = ''
  #      mks.gl.allowUnsupportedDrivers = "TRUE"
  #      mks.vk.allowUnsupportedDevices = "TRUE"
  #    '';
  #  };

    docker.enable = true;
  };

  environment.systemPackages = with pkgs;[
    distrobox
  ];

}
