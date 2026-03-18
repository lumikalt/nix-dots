{
  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/lumi/flake";
  };

  home-manager.users.lumi =
    { inputs, pkgs, ... }:
    {
      imports = [
        inputs.nix-index-database.homeModules.default
      ];
      programs.nix-index.enable = true;
      programs.nix-index-database.comma.enable = true;

      # Better completions
      programs.carapace = {
        enable = true;
      };

      # Shell theme
      programs.starship.enable = true;

      # Better ls
      programs.eza = {
        enable = true;

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

      # Please future lumi, remember to use this.
      programs.aria2 = {
        enable = true;

        settings = {
          dir = "$HOME/dl";
          file-allocation = "falloc";
          log-level = "warn";
          split = "10";
          max-connection-per-server = 10;
          min-split-size = "5M";
          bt-max-peers = "0";
          bt-request-peer-speed-limit = "0";
          max-overall-upload-limit = "512k";
          bt-external-ip = "127.0.0.1";
          dht-listen-port = "6882";
          enable-dht = "true";
          enable-peer-exchange = "true";
          listen-port = "6881";
          bt-force-encryption = "true";
          bt-min-crypto-level = "arc4";
          bt-require-crypto = "true";
          follow-torrent = "mem";
          seed-ratio = "1";
          seed-time = "0";
          socket-recv-buffer-size = "1M";
          event-poll = "epoll";
          realtime-chunk-checksum = "true";
          allow-overwrite = "true";
          always-resume = "true";
          auto-file-renaming = "false";
          continue = "true";
          rpc-save-upload-metadata = "false";
        };
      };

      home.packages = with pkgs; [
        unzip
        rsync
        ffmpeg
        fd
        file
      ];
    };
}
