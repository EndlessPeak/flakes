{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;[
    ((emacsPackagesFor emacs29).emacsWithPackages
      (epkgs:[
        epkgs.vterm
      ]))
  ];
  services.emacs = {
    enable = true;
    package = with pkgs;
      ((emacsPackagesFor emacs29).emacsWithPackages
        (epkgs: [
          epkgs.vterm
        ]));
  };
}
