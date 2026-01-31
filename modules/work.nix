{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      libreoffice
      xournalpp
      rnote

      aspell
      aspellDicts.en
      aspellDicts.en-science
      aspellDicts.en-computers
      aspellDicts.pt_PT
      hunspell
      hunspellDicts.en-us-large
      hunspellDicts.pt-pt
      hunspellDicts.tok
      libspelling
    ];
  };
}
