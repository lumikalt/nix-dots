{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-gtk
      fcitx5-mellow-themes
    ];
  };

  home-manager.users.lumi = {
    programs.anki = {
      # enable = true;

      addons = with pkgs.ankiAddons; [
        review-heatmap
        passfail2
      ];
    };

    home.packages = with pkgs; [
      qt6Packages.fcitx5-configtool
    ];
  };
}
