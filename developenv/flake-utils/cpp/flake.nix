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
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
        # OpenCV Dependencies
        opencv = pkgs.opencv;
        opencvGtk = opencv.override(old:{
          enableGtk2 = true;
          enableGtk3 = true;
          enableDocs = true;
        });
        # SLAM Dependencies
        dbow2 = pkgs.callPackage ./DBoW2.nix { inherit opencvGtk; };
        sophus = pkgs.callPackage ./sophus.nix {};
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
              clang-tools
              clang
              cmake

              # SLAM Dependencies
              sqlite
              suitesparse

              opencvGtk
              dbow2

              eigen
              pangolin
              glew # pangolin 依赖 glew
              # libGLU # pangolin 依赖 openGL
              fmt # sophus 可选依赖于 fmt

              g2o
              yaml-cpp

              # Embedded Dependencies
              gcc-arm-embedded
            ];
          };
        });
}
