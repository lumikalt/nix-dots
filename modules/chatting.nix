{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      stoat-desktop
      signal-desktop
      wasistlos # whatsapp
      gajim # xmpp
    ];

    programs.vesktop = {
      enable = true;
    };
  };
}
