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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system;};
        lib = pkgs.lib;
      in
        {
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
                # 因为我有外部包(tkinter)需要使用
                makeWrapperArgs = [ ];
              }))
            ];
          };
        });
}
