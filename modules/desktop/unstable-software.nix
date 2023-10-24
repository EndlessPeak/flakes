{ config, lib, pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable;[
    # Proxy
    v2raya
  ];
}
