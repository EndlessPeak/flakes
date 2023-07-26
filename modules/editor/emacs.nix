{ config, lib, pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable;[
    ((emacsPackagesFor emacs29).emacsWithPackages
      (epkgs:[
        epkgs.vterm
      ]))
  ];
  services.emacs = {
    enable = true;
    package = with pkgs-unstable;
      ((emacsPackagesFor emacs29).emacsWithPackages
        (epkgs: [
          epkgs.vterm
        ]));
  };
}
