{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set -p PATH $HOME/.config/emacs/bin

      fish_vi_key_bindings
    '';

    plugins = [
      { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
      { name = "pisces"; src = pkgs.fishPlugins.pisces.src; }
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "done"; src = pkgs.fishPlugins.done.src; }
      { name = "colored_man_pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
    ];

    shellAliases = {
      tarnow = "tar -acf";
      untar = "tar -xvf";
      mkd = "mkdir -pv";
      jctl = "journalctl -p 3 -xb";
      icat = "kitty +kitten icat";
      # ls = "eza"; # auto
    };

    shellAbbrs = {
      sudo = "doas";
    };
  };

  programs.nushell = {
    enable = true;

    extraConfig = (toString (builtins.readFile ../configs/nu/env.nu)) + "\n"
      + (toString (builtins.readFile ../configs/nu/completers.nu)) + "\n"
      + (toString (builtins.readFile ../configs/nu/config.nu));
  };

  programs.carapace.enable = true;

  programs.nix-index.package = true;

  programs.starship.enable = true;

  programs.eza = {
    enable = true;

    # enableAliases = true;
    enableAliases = false;
    git = true;
    icons = true;
    extraOptions = [ "--group-directories-first" "--header" ];
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.lf.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
  };

  programs.ripgrep.enable = true;

  home.packages = with pkgs; [
    jq fzf btop grc unzip rsync ffmpeg feh fd file
    comma
  ];
}
