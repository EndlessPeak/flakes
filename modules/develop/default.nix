{ config, lib, ... }:

{
  imports = [
    ./code.nix
    ./embedded.nix
    ./virtualisation.nix
    ./nix-ld.nix
    # ./latex.nix
  ];
}
