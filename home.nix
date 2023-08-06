{ pkgs, lib, inputs, ... }: {
  home.username = "lumi";
  home.homeDirectory = lib.mkForce /home/lumi;
  home.stateVersion = "23.11";

  imports = [
    ./modules {
#      inherit inputs pkgs lib ;
    }
  ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # fonts
    # noto-fonts noto-fonts-cjk noto-fonts-emoji
    # unifont symbola
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # material-icons emacs-all-the-icons-fonts

    # programming
    tree-sitter
    vscode gedit
    # emacs
    nil statix
    # cargo rustc rust-analyzer rustfmt
    # ghc stack haskell-language-server

    # rice
    libnotify
    libsixel brightnessctl
    hyprpicker hyprpaper
    swayidle
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
