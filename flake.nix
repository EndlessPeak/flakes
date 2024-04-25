{
  description = "Xah Lee's NixOS configuration";
  
  # The `outputs` function will return all the build results of the flake. 
  # A flake can have many use cases and different types of outputs.
  # Parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
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

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    });
  
  # nixConfig only affects the flake itself,not the system configuration
  nixConfig ={
    # enable nixcomman and flakes for nixos-rebuild switch --flake
    experimental-features = [ "nix-command" "flakes"];
    # replace official cache with mirrors located in China
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      # "https://cache.nixos.org/"
    ];
  };

  # The `inputs` are the dependencies of the flake.
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  # Only create all nixpkgs instances in this file!
  inputs = {
    # The most widely used is github:owner/name/reference
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Home manager,used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # `inputs.nixpkgs` of home-manager keeps consistent with the `inputs.nixpkgs` of the current flake, 
      # in case of occuring problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust overlay
    # rust-overlay.url = "github:oxalica/rust-overlay";

    # NixOS User Repository
    nur.url = "github:nix-community/NUR";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}