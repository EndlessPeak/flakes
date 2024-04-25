{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;[
    # Embedded Software
    openocd
    cutecom
    # Warning:
    # The following nixpkgs are packaged by xahlee wihout any test!

    # package: nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
    # install: nix-env -i /nix/store/XXXX

    # Or directly call in the following
    # (callPackage ./stm32cubeide.nix {})
  
    stm32cubemx
  ];
  services.udev.packages = with pkgs;[
    stlink
  ];

}

