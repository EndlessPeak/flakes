{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "EndlessPeak";
    userEmail = "endlesspeak@163.com";
    extraConfig = {
      init = { defaultBranch = "main"; };
    };
  };

}
