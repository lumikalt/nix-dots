{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      libreoffice
      xournalpp
      rnote
    ];
  };
}
