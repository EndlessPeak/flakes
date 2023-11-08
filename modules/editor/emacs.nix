{ config, lib, pkgs, inputs, ... }:

{

  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];
  environment.systemPackages = with pkgs;[
    ((emacsPackagesFor emacs-git).emacsWithPackages
      (epkgs:(with epkgs;[
        vterm
        treesit-grammars.with-all-grammars # help tree-sitter and tree-sitter-langs works well
        #tree-sitter-langs
      ])))
    
    # ((emacsPackagesFor emacs29).emacsWithPackages
    #   (epkgs:[
    #     epkgs.vterm
    #   ]))
  ];
  services.emacs = {
    enable = true;
    package = pkgs.emacs-git;
      # ((emacsPackagesFor emacs29).emacsWithPackages
      #   (epkgs: [
      #     epkgs.vterm
      #   ]));
  };

  # replace default editor with emacs
  environment.variables.EDITOR = "emacs";
}
