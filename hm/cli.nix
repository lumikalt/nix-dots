{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      set -p PATH $HOME/.config/emacs/bin
      fish_vi_key_bindings
    '';

    plugins = with pkgs.fishPlugins; [
      puffer # ... -> ../..
      grc # colorize ll, etc.
      done # notification when program finishes with status
      colored-man-pages # self-explanatory
      autopair # self-explanatory
      fish-you-should-use # reminder for aliases
    ];

    shellAliases = {
      tarnow = "tar -acf";
      untar = "tar -xvf";
      mkd = "mkdir -pv";
      jctl = "journalctl -p 3 -xb";
      icat = "kitty +kitten icat";
    };

    shellAbbrs = {
      genpass = "${lib.getExe pkgs.pwgen} -c -n -y -s 32 | head";
    };

    functions = {
      # Search in browser
      ddg = ''
        if count $argv > /dev/null
          ${lib.getExe pkgs.w3m} +15 "https://lite.duckduckgo.com/lite?kd=-1&q=$argv"
        else
          ${lib.getExe pkgs.w3m} "https://lite.duckduckgo.com/lite?kd=-1"
        end
      '';
      hm = "${lib.getExe pkgs.w3m} https://nix-community.github.io/home-manager/options.xhtml";

      backup = {
        argumentNames = [ "filename" ];
        body = "cp -i $filename $filename.bak";
      };

      mkcd = {
        argumentNames = [ "dir" ];
        body = ''
          mkdir $dir
          cd $dir
        '';
      };
    };
  };

  programs.nushell = {
    enable = true;
  };

  # Better completions
  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  # Shell theme
  programs.starship.enable = true;

  # Better ls
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

  # Quick change-directory with autojump
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  # TUI file manager
  programs.lf.enable = true;

  # Better cat
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
    pwgen

    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.pt_PT
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.pt-pt
    hunspellDicts.tok
    libspelling
  ];
}
