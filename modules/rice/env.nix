{
  pkgs,
  lib,
  ...
}:
{
  home-manager.users.lumi = {
    services.mako = {
      enable = true;

      settings = {
        anchor = "top-right";
        default-timeout = 5000;
      };
    };

    services.poweralertd.enable = true;

    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        # Fingerprint sensor needs this
        ignore-empty-password = false;
        show-failed-attempts = true;

        screenshots = true;
        clock = true;

        effect-blur = "20x3";
      };
    };

    services.swayidle = {
      enable = true;

      events = lib.genAttrs [ "before-sleep" "lock" ] (_: "${pkgs.swaylock-effects}/bin/swaylock");
    };

    qt = {
      enable = true;
    };
    gtk = {
      enable = true;

      iconTheme.name = "Papyrus";

      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
      };
      gtk2.extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };

    home.packages = with pkgs; [
      libnotify
      libsixel
      brightnessctl
      hyprpicker
      hyprpaper
      swayidle
      swaybg
      wl-clipboard
      wtype
      bemenu
      networkmanagerapplet

      gruvbox-gtk-theme
      orchis-theme
      bibata-cursors
      papirus-icon-theme
      adwaita-icon-theme
    ];

    home.sessionVariables = {
      TERM = "kitty";
      BROWSER = "firefox";

      # Wayland
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
