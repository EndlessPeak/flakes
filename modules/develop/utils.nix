{ config, lib, pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      # flake = "/home/xahlee/Documents/xahlee-flakes";
    };
  };
  environment.systemPackages = with pkgs;[
    # Search Utils
    fd # replace for find
    ripgrep # replace for grep
    fzf # fzf has a dependency on fd

    # TUI utils
    eza # exa now is renamed to eza,it aims to take place of ls
    bat # replace for cat
    tldr # replace for man page,too long don't read
    zoxide # replace for cd
    delta # replace for diff

    # TUI Programs
    lolcat
    cowsay
    neofetch
    gitui

    # TUI Monitor
    # joshuto
    btop
    # htop

    # Nix Utils
    nh
    nvd
    direnv
    nix-direnv
    nix-prefetch-git
    nix-output-monitor
  ];
}
