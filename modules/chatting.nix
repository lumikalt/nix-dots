{ pkgs, ... }:
{
  home-manager.users.lumi = {
    home.packages = with pkgs; [
      # stoat-desktop # outdated chromium
    ];

    programs.vesktop = {
      enable = true;
    };
  };
}
