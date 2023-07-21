{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;[
    stm32cubemx
    jetbrains.clion
  ];
}
