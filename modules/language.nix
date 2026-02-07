{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-mellow-themes
    ];
  };

  # Should be automatic, but let's be explicit
  environment.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  home-manager.users.lumi = {
    programs.anki = {
      enable = true;

      addons = with pkgs; [
        ankiAddons.review-heatmap
      ];
    };

    home.packages = with pkgs; [
      qt6Packages.fcitx5-configtool
    ];
  };
}
