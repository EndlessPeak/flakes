{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports = [
    ../config
  ];

  home.username = "leesin";
  home.homeDirectory = "/home/leesin";

  xresources.properties = {
    "Xcursor.size" = 13;
    #"Xft.dpi" = 172;
  };

  home.packages = lib.concatLists [
    (with pkgs;[
      # Extract Tools
      zip
      xz
      unzip
      p7zip

      # Search Utils
      fd # replace for find
      ripgrep # replace for grep
      fzf # fzf has a dependency on fd

      # TUI utils

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
      joshuto
      btop
      htop

      # KDE Programs
      # latte-dock is out of date,I want to override it.
      # Refer to https://nixos.org/manual/nixpkgs/stable/#chap-overrides
      (latte-dock.overrideAttrs{
        version = "v0.10";
        src = fetchFromGitLab {
          domain = "invent.kde.org";
          owner = "plasma";
          repo = "latte-dock";
          rev = "a840ac6faa9acb1570f8fa016e7ac7f2e5686e90";
          sha256 = "sha256-+9ksvGB6IRlJ1PXsrLA5PuHFCHs80tkKPAu2iknNEAQ=";
        };
      })

      lightly-qt

      # Video
      vlc
      obs-studio
      ffmpeg

      # Others
      qq
      nur.repos.xddxdd.qqmusic

      # SFTP
      filezilla

      # blog
      hugo
      pandoc

      # tex & org export
      bibtex2html
      texlive.combined.scheme-full
      
      # temporily software
      yt-dlp
    ])
    (with pkgs-unstable;[
      eza # exa now is renamed to eza,it aims to take place of ls

      # lang server
      nixd

    ])
  ];
  # programs.zsh.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
