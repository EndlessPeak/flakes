{ config, lib, pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = 
    (with pkgs;[
      # Language Analysis
      # sbcl # required by emacs lsp vfork
      universal-ctags

      # Rust
      rustup

      # IDE
      jetbrains.clion

    ]) ++
    (with pkgs-unstable;[
      # stm32cubemx
    ]);
}
