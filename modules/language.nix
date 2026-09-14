{ pkgs, lib, ... }:
{
  i18n.extraLocales = [
    "en_GB.UTF-8/UTF-8"
    "pt_PT.UTF-8/UTF-8"
    "ko_KR.UTF-8/UTF-8"
  ];
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-hangul
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-mellow-themes
    ];
  };

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      qt6Packages.fcitx5-configtool
    ];
    home.sessionVariables.GTK_IM_MODULE = lib.mkForce "";
  };
}
