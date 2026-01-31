{
  home-manager.users.lumi =
    { config, lib, ... }:
    {
      programs.gpg.enable = true;

      programs.man.enable = true;

      programs.tealdeer = {
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
          desktop = null;
          publicShare = null;
          templates = null;

          extraConfig = {
            XDG_SCREENSHOTS_DIR = "$HOME/pics/screenshots";
          };

          createDirectories = true;
        };

        mimeApps =
          let
            image = [
              "image/jpeg"
              "image/png"
              "image/webp"
              "image/gif"
              "image/*"
            ];
            video = [
              "video/mp4"
              "video/x-matroska"
              "video/webm"
              "video/*"
            ];
            audio = [
              "audio/mpeg"
              "audio/flac"
              "audio/ogg"
              "audio/*"
            ];
            web = [
              "text/html"
              "x-scheme-handler/http"
              "x-scheme-handler/https"
              "x-scheme-handler/ftp"
              "x-scheme-handler/about"
              "x-scheme-handler/unknown"
              "application/x-extension-htm"
              "application/x-extension-html"
              "application/pdf"
            ];
            table = {
              "application/json" = [ "firefox.desktop" ];
              "application/zip" = [ "thunar.desktop" ];
              "application/x.bittorrent" = [ "qbittorrent.desktop" ];
              "x-scheme-handler/discord" = [ "discord.desktop" ];
            }
            // lib.genAttrs image (_: [ "feh.desktop" ])
            // lib.genAttrs video (_: [ "mpv.desktop" ])
            // lib.genAttrs audio (_: [ "mpv.desktop" ])
            // lib.genAttrs web (_: [ "firefox.desktop" ]);
          in
          {
            enable = true;
            associations.added = table;
            defaultApplications = table;
          };
      };
    };
}
