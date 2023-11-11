{ config, lib, pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = 
    (with pkgs;[
      # Language Analysis
      # sbcl # required by emacs lsp vfork
      universal-ctags

      # CPP
      gcc
      gnumake
      cmake
      clang
      clang-tools

      # Rust
      rustup

      # IDE
      jetbrains.clion

    ]) ++
    (with pkgs-unstable;[
      # stm32cubemx
    ]);
}
