{ pkgs, ... }:
{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      default-timeout = 5000;
    };
  };

  services.poweralertd.enable = true;

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

  home.package = with pkgs; [
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
