{ pkgs, ... }:
{
  virtualization.docker.enable = true;

  home-manageer.users.lumi = {
    home.packages = with pkgs; [
      docker
      dockerTools
    ];
  };
}
