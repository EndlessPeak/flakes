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

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;

      enableNvidia = true;
    };
  };

  environment.systemPackages = with pkgs;[
    distrobox
  ];

}
