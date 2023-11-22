{ config, lib, pkgs, pkgs-unstable, ... }:

{
    environment.systemPackages = 
        (with pkgs;[
            # Language Analysis
            # sbcl # required by emacs lsp vfork
            universal-ctags

            # Rust
            rustup
        ]) ++
        (with pkgs-unstable;[
            # stm32cubemx

            # IDE
            (jetbrains.clion.overrideAttrs (old:{
                postFixup = ''
                    ${old.postFixup}

                    # add ja-netfilter
                    cd $out/clion/bin
                    echo '-javaagent:/home/leesin/Downloads/jetbra/ja-netfilter.jar=jetbrains' >> clion64.vmoptions
                    echo '--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED' >> clion64.vmoptions
                    echo '--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED' >> clion64.vmoptions
                '';
            }))
        ]);
}
