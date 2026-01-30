{ pkgs, ... }:
{
  home-manager.users.lumi = {
    programs.ncmpcpp.enable = true;
    programs.mpv.enable = true;

    programs.calibre.enable = true;

    services.mpd = {
      enable = true;

      network.startWhenNeeded = true;
    };
    services.mpd-mpris.enable = true;
    services.mpd-discord-rpc.enable = true;

    programs.rmpc = {
      enable = true;
    };

    home.packages = with pkgs; [
      pamixer
      playerctl
      vlc
      qbittorrent

      spotify
      nicotine-plus

      krita
    ];
  };
}
