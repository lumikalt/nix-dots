{ pkgs }:
{
  # Videos
  programs.ncmpcpp.enable = true;

  programs.mpv.enable = true;

  # Music
  # spotify vvv

  # Books
  programs.calibre.enable = true;

  home.packages = with pkgs; [
    pamixer
    playerctl
    vlc
    qbittorrent
    spotify
    krita
  ];
}
