{ pkgs, lib, ... }: {
  home.username = "lumi";
  home.homeDirectory = lib.mkForce /home/lumi;
  home.stateVersion = "23.11";

  imports = [ ./modules ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # rice
    libnotify
    libsixel brightnessctl
    hyprpicker hyprpaper
    swayidle
    wl-clipboard wtype
    bemenu

    # theming
    gruvbox-gtk-theme
    orchis-theme
    bibata-cursors
    papirus-icon-theme
    gnome.adwaita-icon-theme

    # env
    xfce.thunar xdg-utils
    networkmanagerapplet

    # libraries
    speechd

    # cli
    aspell aspellDicts.en-science aspellDicts.en hunspell hunspellDicts.en-us

    # chatting
    whatsapp-for-linux

    # work
    libreoffice
    xournalpp
    rnote
  ];

  home.sessionVariables = {
    # EDITOR = "${lib.getExe helix}"; -> managed by the program
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
