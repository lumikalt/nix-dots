{ config, pkgs, lib, ... }: {
  services = {
    udiskie = {
      enable = true;
      automount = true;
    };

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableFishIntegration = true;
    };
  };

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
    userDirs = {
      enable = true;
      documents = "$HOME/docs";
      download = "$HOME/dl";
      videos = "$HOME/vids";
      music = "$HOME/music";
      pictures = "$HOME/pics";
    };
    mimeApps.enable = true;
    mimeApps.associations.added = {
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
    };
    mimeApps.defaultApplications = {
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
    };
  };
}