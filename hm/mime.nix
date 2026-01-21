{ config, ... }: {
  programs = {
    gpg.enable = true;

    man.enable = true;

    tealdeer = {
      enable = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
        };
      };
    };
  };

  xdg = {
    enable = true;

    cacheHome = config.home.homeDirectory + "/.local/cache";

    userDirs = {
      enable = true;

      documents = "$HOME/docs";
      download = "$HOME/dl";
      videos = "$HOME/vids";
      music = "$HOME/music";
      pictures = "$HOME/pics";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/pics/screenshots";
      };

      createDirectories = true;
    };

    mimeApps = let
      table = {
        "text/html" = ["firefox.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/ftp" = ["firefox.desktop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];
        "application/x-extension-htm" = ["firefox.desktop"];
        "application/x-extension-html" = ["firefox.desktop"];
        "application/x-extension-shtml" = ["firefox.desktop"];
        "application/xhtml+xml" = ["firefox.desktop"];
        "application/x-extension-xhtml" = ["firefox.desktop"];
        "application/x-extension-xht" = ["firefox.desktop"];

        "audio/*" = ["mpv.desktop"];
        "video/*" = ["mpv.dekstop"];
        "image/*" = ["feh.desktop"];

        "application/json" = ["firefox.desktop"];
        "application/pdf" = ["firefox.desktop"];
        "application/zip" = ["thunar.desktop"];
        "application/x.bittorrent" = ["qbittorrent.desktop"];

        "x-scheme-handler/discord" = [ "discord.desktop" ];
      };
    in {
      enable = true;
      associations.added = table;
      defaultApplications = table;
    };
  };
}
