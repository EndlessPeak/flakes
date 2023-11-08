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

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Make the Podman socket available in place of the Docker socket, so Docker tools can find the Podman socket.
      dockerSocket.enable = true;

      enableNvidia = true;
    };
  };

  environment.systemPackages = with pkgs;[
    distrobox
  ];

}
