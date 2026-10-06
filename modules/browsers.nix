{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      brave # for chromium
      tor-browser
      w3m
      speechd # TTS
    ];

    programs.firefox = {
      enable = true;

      # Adopt the existing profile in place (keeps tabs, extensions, logins).
      profiles.default = {
        id = 0;
        isDefault = true;
        path = "dxmdnxam.default";
      };
    };
  };
}
