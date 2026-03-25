{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  home-manager.users.lumi = {
    home.packages = with pkgs; [
      docker
      # dockerTools
    ];
  };
}
