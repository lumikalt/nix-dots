{ pkgs, ... }:
{
  home-manager.users.lumi = {
    programs.anki = {
      enable = true;

      addons = with pkgs; [
        ankiAddons.review-heatmap
      ];
    };
  };
}
