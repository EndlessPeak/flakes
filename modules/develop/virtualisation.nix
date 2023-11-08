{ config, lib, pkgs, pkgs-unstable, ... }:

{
  # virtualisation configuration
  virtualisation = {
      vmware.host = {
          enable = true;
          package = pkgs.vmware-workstation;
          extraConfig = ''
            mks.gl.allowUnsupportedDrivers = "TRUE"
            mks.vk.allowUnsupportedDevices = "TRUE"
          '';
      };
  };

}
