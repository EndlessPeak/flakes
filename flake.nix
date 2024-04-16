{
  description = "LeeSin's NixOS Flake Configuration";

  # The `inputs` are the dependencies of the flake.
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  # Only create all nixpkgs instances in this file!
  inputs = {
    # The most widely used is github:owner/name/reference
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager,used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # `inputs.nixpkgs` of home-manager keeps consistent with the `inputs.nixpkgs` of the current flake, in case of occuring problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust overlay
    # rust-overlay.url = "github:oxalica/rust-overlay";

    # NixOS User Repository
    nur.url = "github:nix-community/NUR";

    # flake-root.url = "github:srid/flake-root";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    # nix-ld-rs.inputs.nixpkgs.follows = "nixpkgs";
    # nix-ld-rs.inputs.flake-utils.follows = "flake-utils";

    # flake-compat = {
    #   url = "github:inclyc/flake-compat";
    #   flake = false;
    # };

  };

  # nixConfig only affects the flake itself,not the system configuration
  nixConfig ={
    # enable nixcomman and flakes for nixos-rebuild switch --flake
    experimental-features = [ "nix-command" "flakes"];
    # replace official cache with mirrors located in China
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      # "https://cache.nixos.org/"
    ];
  };

  # The `outputs` function will return all the build results of the flake. 
  # A flake can have many use cases and different types of outputs.
  # Parameters in `outputs` are defined in `inputs` and can be referenced by their names. 
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs@{
    self,
    nixpkgs,
    nur,
    home-manager,
    ...
  }:
    let
      username = "leesin";
      userfullname = "Lee Sin";
      useremail = "endlesspeak@163.com";

      x64_system = "x86_64-linux";
      # allSystems = [ x64_system ];

      x64_specialArgs = {
        pkgs-unstable = import inputs.nixpkgs-unstable {
          system = x64_system;
          config.allowUnfree = true;
        };  
        inputs=inputs;
      };
      common_modules = [
        # use nur overlay instead of the following modules
        # so that the home manager config files can use nur pkgs too
        # nur.nixosModules.nur
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = x64_specialArgs;
          home-manager.users.leesin = import ./home/linux;
        }
      ];
      leesin_laptop_modules = [ ./hosts/FX504GE ];
      leesin_desktop_modules = [ ./hosts/MaxSun ];
    in {
      nixosConfigurations =
        let
          system = x64_system;
          specialArgs = x64_specialArgs;
        in {
          leesin_laptop = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = 
              # use nur overlay 
              [{ nixpkgs.overlays = [ nur.overlay ]; }] ++
              common_modules ++
              leesin_laptop_modules;
          };
          leesin = nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules =
              [{ nixpkgs.overlays = [ nur.overlay ]; }] ++
              common_modules ++
              leesin_desktop_modules; 
          };
        };
    };    
}
