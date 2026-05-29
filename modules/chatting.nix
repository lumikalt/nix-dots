{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      # stoat-desktop # outdated chromium
      signal-desktop
    ];

    programs.vesktop = {
      enable = true;
    };
  };
}
