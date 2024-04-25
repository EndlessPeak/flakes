{ config, lib, pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs;[
    # tex & org export
    bibtex2html
    texlive.combined.scheme-full
  ];

}
