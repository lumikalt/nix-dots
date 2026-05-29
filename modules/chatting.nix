{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      # stoat-desktop # why does this require an outdated chromium
      signal-desktop
      wasistlos # whatsapp
      gajim # xmpp
    ];

    programs.vesktop = {
      enable = true;
    };
  };
}
