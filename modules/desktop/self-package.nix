{ config, pkgs, ... }:
{
    environment.systemPackages = [
        (pkgs.callPackage ../../packages/baidunetdisk/default.nix {})
    ];
}
