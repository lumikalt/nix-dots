{ pkgs, ... }:
{
  # Videos
  programs.ncmpcpp.enable = true;

  programs.mpv.enable = true;

  # Music

  # Books
  program.calibre.enable = true;

  home.packages = with pkgs; [
    pamixer
    playerctl
    vlc
    qbittorrent
    spotify
  ];
}
