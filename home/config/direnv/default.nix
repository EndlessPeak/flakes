{ pkgs, ... }:

{
  # nix-direnv
  programs = {
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  programs.zsh ={
    enable = true;
    initExtra = "source ~/.config/zsh/zshrc\n";
  };
}
