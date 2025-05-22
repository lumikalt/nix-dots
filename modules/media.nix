{ pkgs, inputs, ... }: {
  programs.ncmpcpp.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    pamixer playerctl
    vlc
    qbittorrent
  ];
}
