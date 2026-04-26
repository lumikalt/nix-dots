{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      brave # for chromium
      tor-browser
      w3m
      speechd # TTS
      bitwarden-desktop # club logins
    ];

    programs.firefox = {
      enable = true;
    };

    programs.floorp = {
      enable = true;
    };
  };
}
