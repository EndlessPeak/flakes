{ config, lib, pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  environment.systemPackages = with pkgs;[
    ((emacsPackagesFor emacs-unstable).emacsWithPackages
      (epkgs:[
        epkgs.vterm
      ]))
    
    # ((emacsPackagesFor emacs29).emacsWithPackages
    #   (epkgs:[
    #     epkgs.vterm
    #   ]))
  ];
  services.emacs = {
    enable = true;
    package = pkgs.emacs-unstable;
      # ((emacsPackagesFor emacs29).emacsWithPackages
      #   (epkgs: [
      #     epkgs.vterm
      #   ]));
  };
}
