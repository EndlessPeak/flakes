{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;[
    # Language Analysis
    # sbcl # required by emacs lsp vfork
    universal-ctags

    # Lang Server
    # Rust
    rustup
    # rust-analyzer

    # Python
    # Now we consider use poetry instead of conda
    # Poetry without poetry2nix on NixOS is a bullshit
    # poetry
    # conda

    # Git GUI
    github-desktop

    # Nodejs
    # Used for hugo
    nodejs_21
    
    # stm32cubemx

    # Nix
    nixd

    # Program Analyze
    graphviz # used for gprof2dot, it's required by kcachegrind anyway
    valgrind # used for kcachegrind, produce callgrind or cachegrind data
    libsForQt5.kcachegrind # it will be replace to kdePackages.kcachegrind soon

    # IDE
    jetbrains.rust-rover

    (jetbrains.clion.overrideAttrs (old:{
      postFixup = ''
        ${old.postFixup}

        # add ja-netfilter
        cd $out/clion/bin
        echo '-javaagent:/home/xahlee/Downloads/jetbra/ja-netfilter.jar=jetbrains' >> clion64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED' >> clion64.vmoptions
        echo '--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED' >> clion64.vmoptions
      '';
    }))
  ];
}
