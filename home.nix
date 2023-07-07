{ config, pkgs, lib, ... }: {
  home.username = "lumi";
  home.homeDirectory = lib.mkForce /home/lumi;
  home.stateVersion = "23.11";

  imports = [
    ./modules
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    nerdfonts
    material-icons

    # programming
    tree-sitter
    vscode gedit
    nil statix
    cargo rustc rust-analyzer rustfmt
    ghc stack haskell-language-server

    # rice
    libnotify
    libsixel brightnessctl
    hyprpicker
    swayidle swaylock swaybg
    grim slurp wl-clipboard wtype
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
    xfce.thunar
    
    # cli
    jq fzf btop grc unzip rsync ffmpeg feh
    aspell aspellDicts.en-science aspellDicts.en hunspell hunspellDicts.en-us

    # chatting
    discord # FIXME: add some matrix client

    # work
    libreoffice
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "${lib.getExe helix}"; -> managed by the program
    TERM = "xterm-kitty";
    BROWSER = "firefox";
    # Locale
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    # Wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
