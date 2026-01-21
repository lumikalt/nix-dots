{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set -p PATH $HOME/.config/emacs/bin

      fish_vi_key_bindings
    '';

    plugins = [
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "colored_man_pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];

    shellAliases = {
      tarnow = "tar -acf";
      untar = "tar -xvf";
      mkd = "mkdir -pv";
      jctl = "journalctl -p 3 -xb";
      icat = "kitty +kitten icat";
    };
  };

  programs.nushell = {
    enable = true;
  };

  programs.carapace.enable = true;

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  programs.starship.enable = true;

  programs.eza = {
    enable = true;

    enableFishIntegration = false;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.lf.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };

  programs.ripgrep.enable = true;

  home.packages = with pkgs; [
    jq
    fzf
    btop
    grc
    unzip
    rsync
    ffmpeg
    feh
    fd
    file

    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.pt_PT
    hunspell
    hunspellDicts.en-us
    hunspellDicts.en-us-large
    hunSpellDicts.pt-pt
    hunspellDicts.tok
    libspelling
  ];
}
