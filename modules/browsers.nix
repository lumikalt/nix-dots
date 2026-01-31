{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      tor-browser
      w3m
      speechd # TTS
    ];

    programs.firefox = {
      enable = true;
    };

    programs.floorp = {
      enable = true;
    };
  };
}
