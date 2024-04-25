{ config, pkgs, lib, ... } @ args:

{
  networking = {
    # Easiest to use and most distros use this by default.  
    networkmanager.enable = true; 

    # DNS
    # resolvconf
    resolvconf.dnsExtensionMechanism = false;

    # FireWall
    firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}