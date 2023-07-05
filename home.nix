{
  config,
  pkgs,
  ...
}: {
  home.username = "lumi";
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # shell
    fish
    bat exa
    kitty

    # fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    nerdfonts
    material-icons

    # programming
    git gh # need gh for git auth
    ripgrep
    vscode emacs neovim micro
    nil statix
    cargo rustc rust-analyzer rustfmt
    ghc stack haskell-language-server

    # rice
    mako libnotify
    hyprpaper hyprpicker
    swayidle swaylock
    grim slurp wl-clipboard
    bemenu

    # audio
    pamixer
    playerctl
    vlc
    mpv

    # browser
    firefox

    # chatting
    discord
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
    # EDITOR = "emacs";
  };
}
