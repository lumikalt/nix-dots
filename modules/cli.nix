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
    };

    shellAbbrs = {
      sudo = "doas";
    };
  };

  programs.starship.enable = true;

  programs.exa = {
    enable = true;

    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = ["--group-directories-first" "--header"];
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
}
