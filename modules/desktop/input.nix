{ config, lib, pkgs, ... }:

{
  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      (fcitx5-rime.override {
        rimeDataPkgs = [
          # rime-data
          # config.nur.repos.
          # nur.repos.xddxdd.rime-ice
          nur.repos.linyinfeng.rimePackages.rime-ice
        ];
      })
      fcitx5-chinese-addons
      fcitx5-table-extra
      # The following shows how to use NUR packages
      #config.nur.repos.ruixi-rebirth.fcitx5-pinyin-moegirl
      #config.nur.repos.ruixi-rebirth.fcitx5-pinyin-moegirl
    ];
  };
}
