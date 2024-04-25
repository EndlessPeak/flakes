{
  nixpkgs,
  # nixpkgs-unstable,
  self,
  ...
}: let
  inherit (self) inputs;
  # Modules: Config Files
  ## The following config files contain host's settings
  core = ../modules/core;
  boot = ../modules/boot;
  bootextra = ../modules/boot/extra.nix;
  nvidia = ../modules/nvidia;
  nvidiaprime = ../modules/nvidia/prime.nix;
  desktop = ../modules/desktop;
  develop = ../modules/develop;
  editor = ../modules/editor;
  user = ../modules/user;
  # Modules: Predefined
  ## Use nur overlay instead of nur module
  ## So that the home manager config files can use nur pkgs too
  ## Even I decided not to install any pkgs in home manager
  ## nurModule = inputs.nur.nixosModules.nur;
  nixOverlay = { 
    nixpkgs.overlays = [ 
      inputs.nur.overlay
      inputs.emacs-overlay.overlay
    ]; 
  };
  hmModule = inputs.home-manager.nixosModules.home-manager;

  # Modules: Shared Config Files
  sharedModule = [
    core 
    boot
    nvidia
    hmModule
    nixOverlay
    desktop
    develop
    editor
    user
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.xahlee = {
      imports = [
        ../home
      ];
    };
  };
  
  # Use pkgs-unstable as specialArgs
  # makeSystem = system: {
  #   pkgs-unstable = import nixpkgs-unstable {
  #     inherit system;
  #     config = {
  #       allowUnfree = true;
  #     };
  #   };
  # };
  
in {
  # All the hosts list as follows
  ivara = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = 
      sharedModule ++ 
      [
        { networking.hostName = "ivara"; }
        ./MaxSun
        { inherit home-manager;}
      ]; 
      
    specialArgs = { inherit inputs; }; 
    # // makeSystem system;
  };
  
  titania = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = 
      sharedModule ++ 
      [
        { networking.hostName = "titania"; }
        ./FX504GE
        nvidiaprime
        bootextra
        { inherit home-manager;}
      ];
    specialArgs = { inherit inputs; };
    # // makeSystem system;
  };
}
