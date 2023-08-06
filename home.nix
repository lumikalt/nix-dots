{ pkgs, lib, inputs, ... }: {
  home.username = "lumi";
  home.homeDirectory = lib.mkForce /home/lumi;
  home.stateVersion = "23.11";

  imports = [ ./modules ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # programming
    tree-sitter
    vscode gedit
    # emacs
    nil statix

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

    # media
    pamixer playerctl
    vlc
    qbittorrent

    # env
    xfce.thunar xdg-utils

    # cli
    jq fzf btop grc unzip rsync ffmpeg feh fd file
    aspell aspellDicts.en-science aspellDicts.en hunspell hunspellDicts.en-us

    # chatting
    # FIXME: add some matrix client

    # work
    libreoffice

    # browser
    tor-browser-bundle-bin
  ];

  home.sessionVariables = {
    # EDITOR = "${lib.getExe helix}"; -> managed by the program
    TERM = "xterm-kitty";
    BROWSER = "firefox";

    # Wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
