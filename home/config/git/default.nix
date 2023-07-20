{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "EndlessPeak";
    userEmail = "endlesspeak@163.com";
    extraConfig = {
      core = { pager = "delta"; };
      interactive = { diffFilter = "delta --color-only"; };
      delta = { navigate = true; };
      merge = { conflictstyle = "diff3"; };
      diff = { colorMoved = "default"; };
      init = { defaultBranch = "main"; };
    };
  };

}
