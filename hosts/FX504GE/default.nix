{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  services = {
    xserver = {
      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };
  };
}