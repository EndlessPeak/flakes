{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;[
    universal-ctags
    stm32cubemx
    jetbrains.clion
    openocd
    # Warning:
    # The following nixpkgs are packaged by leesin
    # wihout any test!
    # package: nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
    # install: nix-env -i /nix/store/XXXX
    # Or directly call in the following
    # (callPackage ./stm32cubeide.nix {})
  ];
  services.udev.packages = with pkgs;[
    stlink
  ];
}
