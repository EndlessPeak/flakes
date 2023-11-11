{ config, lib, ... }:

{
  imports = [
    ./code.nix
    ./embedded.nix
    ./virtualisation.nix
    ./latex.nix
  ];
}
