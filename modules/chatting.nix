{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      revolt-desktop # stoat isn't named correctly
      signal-desktop
      wasistlos # whatsapp
      gajim # xmpp
    ];

    programs.vesktop = {
      enable = true;
    };
  };
}
