{
  description = "A Nix-flake-based Python development environment";

  nixConfig ={
    # enable nixcomman and flakes for nixos-rebuild switch --flake
    experimental-features = [ "nix-command" "flakes"];
    # replace official cache with mirrors located in China
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      #"https://cache.nixos.org/"
    ];
    allowUnfree = true;
    cudaSupport = true;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # flake-utils.url = "github:numtide/flake-utils";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "x86_64-linux"
      ];

      # imports = [
      #   inputs.flake-parts.flakeModules.easyOverlay
      # ];

      perSystem = { config, pkgs, system, ... }:
      let
        pkgs = import nixpkgs {inherit system;};
        lib = pkgs.lib;
      in
      {
        # This sets `pkgs` to a nixpkgs with allowUnfree option set.
        _module.args.pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells.default = pkgs.mkShell {
          LD_LIBRARY_PATH = lib.makeLibraryPath [
            # 链接 libstdc++ 等
            pkgs.stdenv.cc.cc
          ];
          packages = with pkgs;[
            # python311Packages.tkinter
            python311Full
            (poetry.overrideAttrs (oldAttrs:{
              # 禁用 --unset PYTHONPATH
              # 因为我有外部包(如tkinter)需要使用
              makeWrapperArgs = [ ];
            }))
          ];
        };
      };
    });
}
