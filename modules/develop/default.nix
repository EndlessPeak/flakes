{ config, lib, ... }:

{
  imports = [
    ./code.nix
    ./utils.nix
    ./nix-ld.nix
    # ./embedded.nix
    # ./virtualisation.nix
    # ./latex.nix
  ];
}