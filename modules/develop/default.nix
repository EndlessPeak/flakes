{ config, lib, ... }:

{
  imports = [
    ./code.nix
    ./virtualisation.nix
    ./latex.nix
  ];
}
