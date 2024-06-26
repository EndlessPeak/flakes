{ pkgs, ... }:

{
  # Enable nix ld
  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;

  # Sets up all the libraries to load
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    glib
    zlib
    openssl
    curl
  ];
}
