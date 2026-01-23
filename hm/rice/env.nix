{
  pkgs,
  lib,
  wallpaper,
  ...
}:
{
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
      ignore-empty-password = false;
      show-failed-attempts = true;

      screenshots = true;
      clock = true;

      effect-blur = "20x3";
      indicator-radius = "200";

      line-color = "ffffff22";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      inside-color = "dcdccc55";
      ring-color = "dcdcdc55";
      ring-ver-color = "33445555";
      key-hl-color = "FFFFFF66";
      separator-color = "00000000";
      layout-bg-color = "00000000";
      layout-border-color = "00000000";
      inside-ver-color = "ffffff22";
      font-size = "24";
      text-color = "FFFFFFFF";
      text-clear-color = "FFFFFFFF";
      text-caps-lock-color = "FFFFFFFF";
      text-ver-color = "FFFFFFFF";
      text-wrong-color = "FFFFFFFF";
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
}
