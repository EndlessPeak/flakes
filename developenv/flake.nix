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
      in
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # gccStdenv
              # llvmPackages_15.stdenv
              # llvmPackages_15.bintools

              gcc
              gdb
              cmake
              eigen
              pangolin
              glew
              fmt

              (pkgs.callPackage ./sophus.nix {})

              # libGLU # pangolin 依赖 openGL
              clang
              clang-tools

	            # clang_16
              # clang-tools_16

              gcc-arm-embedded
            ];
          };
        });
}
