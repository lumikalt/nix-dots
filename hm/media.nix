{ pkgs, ... }:
{

  programs.ncmpcpp.enable = true;
  programs.mpv.enable = true;

  programs.calibre.enable = true;

  home.packages = with pkgs; [
    pamixer
    playerctl
    vlc
    qbittorrent
    spotify
    krita
    
    libreoffice
    xournalpp
    rnote
  ];
}
