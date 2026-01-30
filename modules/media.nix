{ pkgs, ... }:
{
  home-manager.users.lumi = {
    services.syncthing = {
      enable = true;

      settings = {
        devices = {
          "a56".id = "5EVOQTR-QTGO4WF-FWRRLD6-ECPZW3C-HVOQFHM-WRWUVAW-CLLRXI3-N25KXQA";
        };
        folders = {
          "music" = {
            path = "~/music";
            id = "75emw-tgjnp";
          };
        };
      };
    };

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
