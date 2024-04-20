{
  description = "A Nix-flake-based C/C++ development environment";

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
    { self
    , nixpkgs
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        opencv = pkgs.opencv;
        opencvGtk = opencv.override(old:{
          enableGtk2 = true;
          enableGtk3 = true;
          enableDocs = true;
        });
        dbow2 = pkgs.callPackage ./DBoW2.nix { inherit opencvGtk; };
      in
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # gccStdenv
              # llvmPackages_15.stdenv
              # llvmPackages_15.bintools
              # Compiler
              gcc
              gdb
              lldb_16
              clang-tools_16
              clang
              cmake

              # SLAM Dependencies
              sqlite
              suitesparse
              opencvGtk
              dbow2
              g2o
              pangolin
              eigen
              glew
              yaml-cpp
              # libGLU # pangolin requires openGL
            ];
          };
        });
}
